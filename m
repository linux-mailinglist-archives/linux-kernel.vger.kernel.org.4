Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBBD65F2CD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbjAERen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbjAEReZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:34:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C423C75
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 09:34:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8205A61BA7
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 17:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C901C433EF;
        Thu,  5 Jan 2023 17:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672940063;
        bh=1fJkf23oCC2RJXN3Sa96FKGl2kzGrLdl82SeNdIED3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c9POn9KyAvZpA8TrcSCtD9gQCcT8BJmznj4R/0Dq8zNzyRJC9/oPeGCUIhNK1InCE
         4VadieJ0ZyQMxdXDv52cJDDaOPyrASMFMt6tPOCIAk1i5qN2udI0Twn1ZZQ1c145V3
         /qGYeNM0qmvRgx/KZgeh24ZYoBhgsf3q0flkSdMhKA//aSByerLUTFjMt17Am1X/wl
         sZT5gkh6EpgPr6xM/9HGpmtsLvTh0K4qO4mYcAZ0Tr4MwH/fMKvovK8mrbhJo/EkZY
         hYR+RCzdFcPc0pFgXpYxyngvdFf2epPAEZ5I8AUzYOh6UglVUu5FM1ZHyRFsJ+M0BR
         5bMnYXqvTLjEA==
Date:   Thu, 5 Jan 2023 10:34:21 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, Syed.SabaKareem@amd.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] ASoC: amd: ps: Fix uninitialized ret in
 create_acp64_platform_devs()
Message-ID: <Y7cKHZL8e+rfR66a@dev-arch.thelio-3990X>
References: <20230105-wsometimes-uninitialized-pci-ps-c-v1-1-4022fd077959@kernel.org>
 <6bb126b7-1cb4-0c4c-d357-fadc3ffdd3f9@amd.com>
 <Y7cEra00F9PeFFcx@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y7cEra00F9PeFFcx@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 10:11:09AM -0700, Nathan Chancellor wrote:
> On Thu, Jan 05, 2023 at 10:34:10PM +0530, Mukunda,Vijendar wrote:
> > On 05/01/23 21:23, Nathan Chancellor wrote:
> > > Clang warns:
> > >
> > >   sound/soc/amd/ps/pci-ps.c:218:2: error: variable 'ret' is used uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninitialized]
> > >           default:
> > >           ^~~~~~~
> > >   sound/soc/amd/ps/pci-ps.c:239:9: note: uninitialized use occurs here
> > >           return ret;
> > >                  ^~~
> > >   sound/soc/amd/ps/pci-ps.c:190:9: note: initialize the variable 'ret' to silence this warning
> > >           int ret;
> > >                  ^
> > >                   = 0
> > >   1 error generated.
> > >
> > > Return -ENODEV, which matches the debug message's description of this block.
> > >
> > > Fixes: 1d325cdaf7a2 ("ASoC: amd: ps: refactor platform device creation logic")
> > > Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FClangBuiltLinux%2Flinux%2Fissues%2F1779&data=05%7C01%7CVijendar.Mukunda%40amd.com%7Cad26656c3d2f4c75d00208daef350528%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638085308267581104%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=eeHVStOIOcy%2FdDISOKlGNeyEwx4i5AtJZmQ5dcNB7XQ%3D&reserved=0
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > > ---
> > >  sound/soc/amd/ps/pci-ps.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
> > > index 401cfd0036be..f54b9fd9c3ce 100644
> > > --- a/sound/soc/amd/ps/pci-ps.c
> > > +++ b/sound/soc/amd/ps/pci-ps.c
> > > @@ -217,6 +217,7 @@ static int create_acp63_platform_devs(struct pci_dev *pci, struct acp63_dev_data
> > >  		break;
> > >  	default:
> > >  		dev_dbg(&pci->dev, "No PDM devices found\n");
> > > +		ret = -ENODEV;
> > ACP PCI driver supports different configurations. As per design , even  when no child dev
> > nodes are created , ACP driver probe should be successful. ACP PCI driver probe failure
> > causes power state transition failures when no child device nodes are created.
> > We should not return -ENODEV in this case.
> > return 0 is enough in this case. No need to de-init the ACP.
> 
> Thank you for the review and input and sorry for getting it wrong! I
> will send a v2 replacing 'break;' with 'return 0;' shortly.

Actually, I re-read your message and looked at the code now that I am
back in front of my keyboard and I am a little confused by your message.
Should 'goto de_init' be replaced with 'return 0' to avoid the call to
acp63_deinit() or should ret just be initialized to 0 in this block so
that the call to acp63_deinit() still happens?

Thanks again for your input!
Nathan

> > >  		goto de_init;
> > >  	}
> > >  
> > >
> > > ---
> > > base-commit: 03178b4f7e2c59ead102e5ab5acb82ce1eaefe46
> > > change-id: 20230105-wsometimes-uninitialized-pci-ps-c-3b5725c6ed31
> > >
> > > Best regards,
> > 
> 
