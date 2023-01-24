Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555E86790B2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 07:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjAXGOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 01:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbjAXGOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 01:14:47 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B163C2A;
        Mon, 23 Jan 2023 22:14:46 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id m11so2000024pji.0;
        Mon, 23 Jan 2023 22:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JPg0zBwK5R4M0uazOj7k/ulWnghf3NRsfEnId418SZQ=;
        b=ZQnsVoitd43K4cfVX8Qp+mcHwJ4eKL6d3izT2/lZumdY0kNqkWHZzB04XYYReM3meI
         grWdzaTDPwjdBbti5dQHAYIgUIMROM+mvi+PcYZP9GeEdCaH2TsreqVbzMDqerfGhzA7
         pbTGFPVOirFztkYT73/+Jd7rJ/+N5jPgRyThWnjN088vuNh2zuMeVGFMnbC6hvqucTtd
         3GTpq3jOSq3bEbRGtpbId77WPVVBYIMlAoqL/jF/s6hIwDrnBPglvdhifAVouiURiErX
         CK6IVibY73/lykNvJ28Jb7SreDopnZ+RygNF0cZEQCRADqoKTWZK2CtY4P/fKqYLEDQx
         UVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JPg0zBwK5R4M0uazOj7k/ulWnghf3NRsfEnId418SZQ=;
        b=zPje3tNZZKvTvcB2DW+1Qfuq1oitN/Kx+9HFGrj7NZ1+n4G9CUGsYpYYZBlctTGQA5
         ojlGuxPWxVvflV8tyDLtcWr/BjLiRUcMiRnaLd03EoTnG6Rqc+NIA6HRo9YJdbHghtYc
         m7LChV0kZBjl0sF1I6IraJWez9VmNcJ+Yg/+q6cpu3/ReDoEuSbA0iRJHvDyLn6YdxWi
         IIX34/eJWOyb51HoyxT/S9rRA99/vVWn1eTBxDniFt9RdWQxBsvVDKxioDPiNegZJEsP
         diSlwzlPPAF7cjNvcOgca0QtFXcqM2Bu/hzSSQBT+gQZJcNsYrrYNiQaGzcNylv/jB0V
         7IbA==
X-Gm-Message-State: AFqh2komRubWSejrCpY1DaLv5+DlzUIYhCVB+FYm2OK3M8rD0ELnPJUi
        NojyxwwVcwS+FiKBUm8qpHI=
X-Google-Smtp-Source: AMrXdXue5GwSXqBrPOQ5gcWyNdlp1wljUutISdRZwGnJnL05AWPDz1z7wf/tvlz2HDCjUfgtYzf8Ig==
X-Received: by 2002:a05:6a20:6595:b0:b5:46fa:24e8 with SMTP id p21-20020a056a20659500b000b546fa24e8mr26963663pzh.38.1674540885243;
        Mon, 23 Jan 2023 22:14:45 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:8c28:6024:68cf:c1b6])
        by smtp.gmail.com with ESMTPSA id p20-20020a056a000a1400b0057447bb0ddcsm656736pfh.49.2023.01.23.22.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 22:14:44 -0800 (PST)
Date:   Mon, 23 Jan 2023 22:14:40 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Wu <joewu@msi.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-input@vger.kernel.org, chrome-platform@lists.linux.dev,
        Benson Leung <bleung@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Derek Huang <derekhuang@google.com>,
        "Dustin L . Howett" <dustin@howett.net>, Joe Wu <joewu@msi.com>,
        Furquan Shaikh <furquan@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [PATCH] cros_ec_keyb: Add 3 buttons for monitor function
Message-ID: <Y893UP6FIeGxWSXz@google.com>
References: <20221222063950.26018-1-joewu@msi.com>
 <Y8p6THz2jjKEoMrJ@kroah.com>
 <Y8rOQqhWcVAv8gmN@google.com>
 <Y8uTt3zXgGPmevkb@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8uTt3zXgGPmevkb@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 08:26:47AM +0100, Greg Kroah-Hartman wrote:
> On Fri, Jan 20, 2023 at 09:24:18AM -0800, Dmitry Torokhov wrote:
> > On Fri, Jan 20, 2023 at 12:26:04PM +0100, Greg Kroah-Hartman wrote:
> > > On Thu, Dec 22, 2022 at 02:39:50PM +0800, Joe Wu wrote:
> > > > Add 3 extra buttons: 'brightness up', 'brightness down'
> > > > and 'screen lock' to support monitor manipulating function.
> > > > 
> > > > Signed-off-by: Joe Wu <joewu@msi.com>
> > > 
> > > From: line does not match the signed-off-by (and is an invalid email
> > > address...)
> > 
> > What do you mean "it's an invalid email address"? You can definitely
> > send emails there... I prefer people not to use Google partner domain
> > accounts in the hope that their employment might outlast their
> > involvement in Google projects, but that is it.
> 
> I was told that this was not a valid email address to send and receive
> emails from, and was only an email alias given to companies to interact
> with Google through their gerrit systems.  If that is incorrect, I'll
> not complain about this anymore, but someone needs to please verify this
> for me before I do so :)

Not solely for gerrit, there are other systems at Google (for example
the issue tracker) that require Google account and that is why we create
them for partners. It is however a real account that can send and
receive e-mails. Whether anyone is looking at it, especially after they
moved to other projects, is a separate topic, but it is the same with a
random gmail or whatever account that people are creating to submit a
patch or two.

> 
> But even if it is valid, should we accept it as a way to get in contact
> with the original submitter over time?

I believe that a real corp account is preferable for getting in contact
with the engineer who submitted the patch. Unfortunately corp accounts
often unsuitable for submitting patches to the kernel. Outgoing mail
servers either force HTML, mangle the text, or add legal-sounding
footers that result in snark replies. So submitters often try to use
another account to submit the code, such us a throwaway gmail account,
or as in this case, our "partner domain" account. Neither is ideal but
we require from to match sign-off (including email part) and complain
about sane option of overriding "from" in the mail body to be something
more sensitive, like the email that is actually used by the person in
question.

Again, I have more trust for patches sent as "Joe Wu
<joewu@msi.corp-partner.google.com>" with body

From: Joe Wu <joewu@msi.com>
...
Signed-off-by: Joe Wu <joewu@msi.com>
...

then patches sent and signed off as "Joe Wu <joemsi-oss@gmail.com>"
because I actually know that there is a process for establishing and
managing that @msi.corp-partner.google.com.

> 
> > I think if we ask people to stick "From: <whatever the company address
> > is" in the body of the patch we can ignore the difference between sender
> > address and from/signed-off-by when they use partner domain accounts. If
> > anything, such accounts have better vetting than a random gmail or other
> > free email service account some vendors have to create to be able to
> > send a plain-text emails that we require. I mean, we have
> > "Signed-off-by: George Spelvin <lkml@sdf.org>" present in our git
> > history and nobody bats an eye...
> 
> Oh lots of people "batted an eye" about that one, I've had too many
> meetings with lawyers about that, which is one reason I now verify email
> addresses like I did here.

Would you attempt to verify it is you saw a sign-off from "Daniil Kharms
<dank@gmail.com>"? What is the trigger for verification? How rigorous is
it?

Thanks.

-- 
Dmitry
