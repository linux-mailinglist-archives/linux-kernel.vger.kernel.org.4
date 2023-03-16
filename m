Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62FE6BCB68
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjCPJvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjCPJu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:50:59 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E5D580D4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:50:54 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x13so5221951edd.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678960253;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jBsCdl9YocCAf0arjdLy7xl1yCYtEJHXhUtG9+jRSPE=;
        b=obUK2zgAT0FWDrryCLe0nn5fjpIL+XW9VOtdiDoMK5AWeP9rIDWjsLJ26VKEqJrjrR
         M4zFjsbg4ZjPNmJcZ3/7IaiG5aXudlgAcrwMccMA/iPz8WjtGPsQTsMjff/RTN8GRjiU
         PCkScZtE5SWIr6Sz/ztmJDqtAeY3zFzQDKFy8Pfa7N6THWcf3QDoryMA1c05j4kZW8d1
         Bftxj/+gwg61SwK6PHBNG/1zQlm5XDnRWQx/rskXvktt+ZjPgCKSQ28J3lYOQjzgay+B
         wGn8dHyM0vZx3ih/F+ewKBm4dOOGqQvbnw9dfyYC6UVzda9qaB5AbqNpRawiuaH2jaVw
         OQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678960253;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jBsCdl9YocCAf0arjdLy7xl1yCYtEJHXhUtG9+jRSPE=;
        b=jRn8UdNdujxZ7olBiXTsCSIF2Tl4Diz/DfxoNd84BlbdNsKk7lIEzQJIvYEopCOMVZ
         63mJZ1hyH6GfZBBdP91HY0lGmZ9TOhyZnL57qNDpyQn8myXtQN5nbKzu/scpNxBE4nHB
         nV67s4hvBDW7J5JdrCMQHQmK1rWnFzd9fPVz1tGU/wFQpZ6gB9KCV1dcBzV3889sj3q9
         kiac7WvlHa7LA7z0nOkFZ0EHqReaROEVYptqyseXFYj36JOBYUwqvwws8uGKQyiPEA4T
         mZazo5ytaSoh2u1RfNOUSX4dcG4EsPY7lmjB6pdhnWl2rl1n+hMQuNlaLTy1ZgBN4Dtp
         CS0w==
X-Gm-Message-State: AO0yUKWeBUFNJXTfRSPHcEe0ltKD+Q5DuUxN5S046S+ebmVgB5pFbbH6
        v2rthoT6Gf/ln+kvTJR4auc=
X-Google-Smtp-Source: AK7set9zy8miZDiRl1KvkR+eVp1koEm1rHR5bO/wZSTbgFw8h3D5eIu60J/Wi+tYyAA2SzoTx9WZGQ==
X-Received: by 2002:a17:906:3ada:b0:91e:9cc8:427b with SMTP id z26-20020a1709063ada00b0091e9cc8427bmr8659236ejd.25.1678960252868;
        Thu, 16 Mar 2023 02:50:52 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.209.88])
        by smtp.gmail.com with ESMTPSA id n3-20020a1709061d0300b009307ddcd13esm520185ejh.119.2023.03.16.02.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 02:50:52 -0700 (PDT)
Date:   Thu, 16 Mar 2023 14:50:50 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] staging: axis-fifo: initialize timeouts in probe only
Message-ID: <ZBLmev7BaIhYQXIz@khadija-virtual-machine>
References: <ZA9mThZ7NyRrQAMX@khadija-virtual-machine>
 <2168386.Az4OtozEo7@suse>
 <ZBHOi8vA/LpCyLTJ@khadija-virtual-machine>
 <3096768.uvML7RA1vL@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3096768.uvML7RA1vL@suse>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 05:44:47PM +0100, Fabio M. De Francesco wrote:
> On mercoledì 15 marzo 2023 14:56:27 CET Khadija Kamran wrote:
> > On Wed, Mar 15, 2023 at 02:13:51PM +0100, Fabio M. De Francesco wrote:
> > > On mercoledì 15 marzo 2023 13:32:55 CET Khadija Kamran wrote:
> > > > On Tue, Mar 14, 2023 at 04:57:47PM -0700, Alison Schofield wrote:
> > > > > My guess is that this patch gets ignored because it has a lower 
> version
> > > > > number than a previous patch.
> > > > > 
> > > > > Take the feedback given here, and rev to
> > > > > [PATCH v5] staging: axis-fifo: initialize timeouts in probe only
> > > > > 
> > > > > Be sure the Changelog, below the --- explains the journey.
> > > > > 
> > > > > Changes in v5:
> > > > > 
> > > > > Changes in v4:
> > > > > 
> > > > > Changes in v3:
> > > > 
> > > > > Changes in v2:
> > > > Hey Alison!
> > > 
> > > Hi Khadija,
> > > 
> > > Please put one or two blank lines between the last message you are 
> replying
> > > and the new you are writing (exactly as I'm doing here between "Hey 
> Alison!"
> > > and "Hi Khadija").
> > 
> > Hey Fabio!
> > 
> > Sorry about that. This was pointed by Alison before and I have been
> > adding spaces since then. Hopefully I am doing it right this time.
> > 
> You are doing right this time :-)
> >
> > > > Based on Nathan's feedback I am trying to recompile and send a patch
> > > > without any warnings.
> > > 
> > > Great!
> > > 
> > > > As suggested by Fabio, I am running "make w=1 -jX" command to see if I
> > > > get any warnings.
> > > 
> > > I suppose that "w=1" is a typo. The option is enabled with "W=1" (capital
> > > case, Linux and all UNIX-like are case-sensitive).
> > 
> > Okay. I should re-run it with "W=1".
> > 
> > > > But it is taking a lot of time, is there any way of
> > > > speeding it up?
> > > 
> > > What is you choice for 'X' in "-jX"?
> > 
> > I used "-j4".
> > 
> > > Did you try with the exact number of logical cores?
> > > Are you building into a VM with enough logical cores?
> > > If you are building into a VM, did you reserve enough RAM?
> > 
> > I am using Ubuntu 22.04.01 with the help of VM on VMware.
> > My machine has 13GB RAM and 2 processors(4 cores each).
> 
> Therefore, you are using a Linux guest on a Linux host. This is a wise choice. 
> However, you didn't say where you are running your builds...

Hey Fabio!

I am not using a Linux guest on Linux host. Sorry if I did not explain
it right. I am using Windows 10 and in order to run Ubuntu, I have
created a VM(on VMWare). This VM has 13GB RAM and 2 processors(4 cores
each).
Thank you!

Regards,
Khadija
> 
> I mean, the better things to do are the following steps:
> 
> 1) Your workspace with the staging tree should stay in the host.
> 2) Shut down your guest in order to have all RAM and all logical processors 
> available for the build.
> 3) Run "make -j8" in the host. Since you shutdown your guest VM you can use 
> all 8 logical cores and the maximum available RAM (without the VM draining 
> resources while building)
> 4) When the build is done, switch on your VM on VMware with at least 4 logical 
> cores and 6GB of reserved RAM.
> 5) Mount your cloned base directory as a shared folder between host and guest.
> 6) In the guest, 'cd' to the shared folder and then run "make modules_install 
> install" (in the guest, attention). This will install and configure the 
> kernel, the modules, GRUB2 and everything else in your guest VM.
> 7) Reboot the VM and test your patches.
> 
> This procedure will speed up your next builds.
> The fundamental point is that you don't need to partition precious resources 
> while building, Do everything without running the VM and switch it on only for 
> install and tests. Since you only build in the host but never install and boot 
> in it, you don't risk any system's damage.
> 
> This is what I do for Kernel development purposes.
> 
> I hope it helps to answer your question about how to run fast recompilation.
> 
> Fabio  
> 
> 
> > 
> > > Please read carefully my questions above and try to understand your
> > > environment and reply, so that I can help you more effectively.
> > > 
> > > > If this doesn't work then I have to follow the steps to reproduce in lkp
> > > > mail as you said before.
> > > 
> > > The steps to reproduce will take your precious time and use more 
> resources.
> > > Again, try to respond my questions.
> > > 
> > > > After dealing with these warnings I will send a [PATCH v5], following
> > > > your instructions above.
> > > 
> > > Sorry for inadvertently overlooking to warn you about to send a message to
> > > Greg and ask him to drop your first 3 + 1 patches. Now you are doing good 
> by
> > > following what Alison suggested: send v5 and write the log of revisions
> > > under
> > > the three dashes (exactly how Alison explained).
> > > 
> > > > Kindly, let me know if I am on the wrong track.
> > > > Thank you!
> > > 
> > > I think you are in the right track.
> > > Let's try to speed up your builds because you'll need to build again your
> > > kernel many, many times for future works.
> > 
> > Okay great! Thank you.
> > 
> > Regards,
> > Khadija
> > 
> > > Thanks,
> > > 
> > > Fabio
> 
> 
> 
> 
