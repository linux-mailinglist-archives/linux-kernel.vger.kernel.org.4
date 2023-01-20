Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A9F675B3B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjATRYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjATRYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:24:45 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FBDC4EAA;
        Fri, 20 Jan 2023 09:24:24 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id z20so3933356plc.2;
        Fri, 20 Jan 2023 09:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lXHFUqYMA81z5/4QWzsBDmmfnfiAGwft9ib/dJiqERE=;
        b=Q6KlvDHcgN8LTA6RPXCIlBvXcsrxe8XHEyB7D4zJb1fuySw35C3PC+7cC07gL2DDpE
         ztum/4dfo2nFbVBbhcIUGGDKWpHv+8Y6tEPrKp56E1jOC1z5yFA+3n1lXxvp+I5R7OIF
         m93LLV4A38DJglYnRYeCYG2J3b0xV+I2S4tW7/oLyaWrmqZRttuEkmQjr5EnaCEEY9iH
         B9BOAqxsUy47OUOdZ9F9ts61W0WLCstD3a67/bi8ScuH5/1JDS+ilKGCBkoivSpQPQlu
         OyfqB8DG+fBqg6CpeLG7PaOPJf/W/wfVlNWSK/cvYv/tIqEPMn6FsA73HVcWHpoveeVp
         jFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lXHFUqYMA81z5/4QWzsBDmmfnfiAGwft9ib/dJiqERE=;
        b=0X1f2eTFB0BbD9/1o2pDpZLhOdpfSGMnj/BPIgPasri21E1yNe9Z7dCT/dnrQKBIkN
         7f+fKfn1mMYjeJhKE1YwJ/5L6v18PbP6AAhqRvfGttbX1+i7JZMpcvniUbKiEDphSgCt
         Z5sWWRYW4IIYc8yVxG7QV9v0Qs/DIWk2IPtAb+s6DLT/848Z4VU+esWvTMF7LRr6fAPY
         Fcle4s9P1ncvTNge4C+aCAtdNT4wTN7flngppH3bvB4HjyoFnjg5+j8ZHBkE54zNbKxQ
         jimQPmmN8zlUUI+yPdNFZ3O8lnsj6QwVysPR6olMHELbNU2XSMlsQGqbD7hV1EgDXMjJ
         /FPg==
X-Gm-Message-State: AFqh2krKW5guhZ5sHnJuDIzUVInwc04GKXGwHQvsCCBPD9PBS0IkIVOw
        hI6tax+PC6WC2cuVDPm+Nl0=
X-Google-Smtp-Source: AMrXdXsnPAfV/Va8Ok5ZiLV8eE3SVtsOmVIwYH5OdnJv7qLEIq/eyq1QteagJINpb0N8yv3z+FkX6w==
X-Received: by 2002:a17:903:1c6:b0:195:e590:c7c6 with SMTP id e6-20020a17090301c600b00195e590c7c6mr4003519plh.22.1674235463163;
        Fri, 20 Jan 2023 09:24:23 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:3bfe:a22:9187:ed3b])
        by smtp.gmail.com with ESMTPSA id m11-20020a170902db0b00b00186a2274382sm27330649plx.76.2023.01.20.09.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 09:24:22 -0800 (PST)
Date:   Fri, 20 Jan 2023 09:24:18 -0800
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
Message-ID: <Y8rOQqhWcVAv8gmN@google.com>
References: <20221222063950.26018-1-joewu@msi.com>
 <Y8p6THz2jjKEoMrJ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8p6THz2jjKEoMrJ@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 12:26:04PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Dec 22, 2022 at 02:39:50PM +0800, Joe Wu wrote:
> > Add 3 extra buttons: 'brightness up', 'brightness down'
> > and 'screen lock' to support monitor manipulating function.
> > 
> > Signed-off-by: Joe Wu <joewu@msi.com>
> 
> From: line does not match the signed-off-by (and is an invalid email
> address...)

What do you mean "it's an invalid email address"? You can definitely
send emails there... I prefer people not to use Google partner domain
accounts in the hope that their employment might outlast their
involvement in Google projects, but that is it.

I think if we ask people to stick "From: <whatever the company address
is" in the body of the patch we can ignore the difference between sender
address and from/signed-off-by when they use partner domain accounts. If
anything, such accounts have better vetting than a random gmail or other
free email service account some vendors have to create to be able to
send a plain-text emails that we require. I mean, we have
"Signed-off-by: George Spelvin <lkml@sdf.org>" present in our git
history and nobody bats an eye...

Thanks.

-- 
Dmitry
