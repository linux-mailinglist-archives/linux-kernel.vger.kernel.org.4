Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B15C6ADE0E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjCGLye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjCGLyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:54:09 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3180F3B216;
        Tue,  7 Mar 2023 03:53:15 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id ay14so47398275edb.11;
        Tue, 07 Mar 2023 03:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678189993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5NkdPSyehjwKYmLvWLkyPWmKGiOtGMMxDEWqdtEMk4c=;
        b=LcKQCUjPJ5xurUOVBzKyRhj8aqcwhIcfMTHS9lGxeOcBwLG1U1JDGb4Tg+XVjhTzIW
         UKv+8jh1Cz9RTgdECginimU7MDFDcDChE5NEjrw7cY8eAIsMKFOK1Z3901fobBpWRBb4
         XZpHQWgKsTbwo2zgAQh3Dz1VzDixUIz8JsrxElQkTP2wlNTW7yiINhoA/Fu47mihEKmG
         fP6IZBbiL181Om71kvgQfEiMpynLaist+GWtMyw17tGZiPTn5Osc4sO1EXpGoJNahbzD
         R+Drld/kn5WmdA4Iy7S5gLCvJiVflR+8diTTuWfOk3PIcfly67iBCcvuV1aBuTGMFHiF
         jFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678189993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NkdPSyehjwKYmLvWLkyPWmKGiOtGMMxDEWqdtEMk4c=;
        b=P58EDZoVGSm9ixStjvwT60Ee7J1OvYr4/B0tm3g5BafeMp3ubjqyTRQkzB62OyD9ar
         sc/UucZTQ5PtcPE8fgZQf7fiRdIJ9vaBcVZ4/v7BP38f7fUhraxHohi4tbopaBbWJ46M
         IEIj2Maa+phkQlXkjRpHPI+TlY2sCMHn/XF+bZmSxo5x9/kIt/yKLiQS6RoZ+Kz3S2R6
         j7fHLWT8cXiQBPvQN299A/dkRvEbeTQ+hCzkU7Rzh1tR7tzK6RwyOVqvzj1J7H5RnqtC
         w9ov+69VDJ+x72jekc1h08qWG7kChwqOu0o3mVrk+xkPwEmEnYJs4w9xV55f9rudKxZN
         i3GQ==
X-Gm-Message-State: AO0yUKW3rS9Cv2JPQ5LN4aHjQKCMGO8Pp4g3heSEPMHutzxFwjWxKwct
        GEu0Tj/eXw20mscR9LK7T0M=
X-Google-Smtp-Source: AK7set9QlVQN6PT52JS2bYSSrKReY8tkz33LHDy5O0ZVgpczcuJmrynGdrhAh9fM2uNmqgyvfhPnjQ==
X-Received: by 2002:aa7:c396:0:b0:4bc:f925:5dbe with SMTP id k22-20020aa7c396000000b004bcf9255dbemr12560259edq.42.1678189993725;
        Tue, 07 Mar 2023 03:53:13 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s30-20020a508d1e000000b004c5d1a15bd5sm2586002eds.69.2023.03.07.03.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 03:53:13 -0800 (PST)
Date:   Tue, 7 Mar 2023 14:53:04 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>, oe-kbuild@lists.linux.dev,
        lkp@intel.com
Cc:     Hillf Danton <hdanton@sina.com>,
        Masami Ichikawa <masami.ichikawa@miraclelinux.com>,
        cip-dev <cip-dev@lists.cip-project.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, lwn@lwn.net, smatch@vger.kernel.org
Subject: Re: Who is looking at CVEs to prevent them?
Message-ID: <6d1ad8e9-2bec-4cd4-b4dd-595c88855274@kili.mountain>
References: <CAODzB9qjdhQkZ+tALHpDLHoK7GAf8Uybfzp8mxXt=Dwnn_0RjA@mail.gmail.com>
 <20230307110029.1947-1-hdanton@sina.com>
 <b27c7950-873a-f0e9-d7b4-322bb941a11f@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b27c7950-873a-f0e9-d7b4-322bb941a11f@suse.cz>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 12:42:03PM +0100, Vlastimil Babka wrote:
> Why do you keep adding linux-mm to the Cc list of random threads that are
> not about MM?

That's kbuild-bot stuff.  The kbuild-bot generates those emails and I
just look them over and hit send.

I don't why the kbuild bot CCs linux-mm either...  Let me ask the devs
about that.  A lot of the -mm warning are correct but just the CC list
is weird.

The kbuild-bot stuff is really nice for me.  The kbuild-bot doesn't use
the cross function DB so everything is local to the function and easy to
review.

regards,
dan carpenter


