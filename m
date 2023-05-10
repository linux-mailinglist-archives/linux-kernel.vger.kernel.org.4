Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6015E6FDD57
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 14:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbjEJMAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 08:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236894AbjEJMAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 08:00:05 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218827DB6
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 05:00:02 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50dba8a52dcso12120a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 05:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683720000; x=1686312000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPosaf8MCsgv6yWNmFA6HsxG7j+lWW9zDOaIVLm0zpY=;
        b=ax7zBY6QKkRaU/GzkWDmTLjsLMhktpT0tZFnAzY6NwU7sMLMh9GeoeQCIlxwrcpNUV
         kNCA0uFaCpSDM3UtnDxz7QGNeeGZy76yhRq1w5FKmpVO6Frwrt1WmNFSBxez9X098DtK
         ef08Xpup/2FB09NUpbxVKDr3cEooVEbhm5xz0oc4UB9sLFNnTgrapexbfbdmpsPFvecD
         9GK0KN10z7vA1LSGsvOtFp2qLB9NgvXP21DOUN9twmWmadd2lixAEUbRBbM8AkF79zDM
         HJRI4rHvwAdDPUchkrsCiROTiwfXGsV28calQh1UBniWCdoM5Jgr29Psdv5sBI87YSQq
         cdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683720000; x=1686312000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPosaf8MCsgv6yWNmFA6HsxG7j+lWW9zDOaIVLm0zpY=;
        b=gV3kahUNJNzgtGWpQESMw7Z2HfGAmmdsEavTjhtdnlvU96n9QvE73lHbjRy1Eth/in
         BkQR4ORRS5YAybqOupUk9d7j03tqoht6Zdl3BPBzUQGzIFXEVFhTtUXDm1vAk+tOaiCf
         n/914KS5uk5E6L4doqkZqbPcMuDnQv69WPzkxVqdAWh2EOcoFzEm2zIxVDLWK7Nl7lHa
         KoKhieQ2VR06ClhESXjc7WtxTJrqRmUJxSLh24t8X7ceaipjobSAKY1UfVdGXC69MYC7
         pKjAdOK24X6ynB4IPEU13aNxtv37023NKpnzNl4Ct8HNMuRh7FFe5WE+90U7xJELNv0P
         PvPQ==
X-Gm-Message-State: AC+VfDykDRgonjItFPXecAwcNDVV/Mjl7iaC9TmM6bmWy6CM6/zw8NYm
        AEHoTXHDX79JucJdt857ERijaMTdglhFRHf31TE9ag==
X-Google-Smtp-Source: ACHHUZ48tUOtI2HQKCwXUxW/aTOeV3Q3jR+Q1zirxQyJ78c2J7awWW2F19Hr3V8bJW8FX/0a+xcCKnlFCBT+kHNJZpQ=
X-Received: by 2002:a05:6402:2744:b0:506:90c4:b63b with SMTP id
 z4-20020a056402274400b0050690c4b63bmr103304edd.4.1683720000454; Wed, 10 May
 2023 05:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230504092142.4190069-1-yixuanjiang@google.com> <2023050644-dwarf-shabby-d44d@gregkh>
In-Reply-To: <2023050644-dwarf-shabby-d44d@gregkh>
From:   Yixuan Jiang <yixuanjiang@google.com>
Date:   Wed, 10 May 2023 19:59:49 +0800
Message-ID: <CAGJzVQGxDHa83uV0w4Q35UaGpwNhLpKzcZ5y_qsfd4ELDi+OnA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: soc-pcm: Fix and cleanup DPCM locking
To:     Greg KH <greg@kroah.com>
Cc:     tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> =E6=96=BC 2023=E5=B9=B45=E6=9C=886=E6=97=A5 =E9=80=
=B1=E5=85=AD =E4=B8=8B=E5=8D=881:56=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, May 04, 2023 at 05:21:42PM +0800, yixuanjiang wrote:
> > From: Takashi Iwai <tiwai@suse.de>
> >
> > The existing locking for DPCM has several issues
> > a) a confusing mix of card->mutex and card->pcm_mutex.
> > b) a dpcm_lock spinlock added inconsistently and on paths that could
> > be recursively taken. The use of irqsave/irqrestore was also overkill.
> >
> > The suggested model is:
> >
> > 1) The pcm_mutex is the top-most protection of BE links in the FE. The
> > pcm_mutex is applied always on either the top PCM callbacks or the
> > external call from DAPM, not taken in the internal functions.
> >
> > 2) the FE stream lock is taken in higher levels before invoking
> > dpcm_be_dai_trigger()
> >
> > 3) when adding and deleting a BE, both the pcm_mutex and FE stream
> > lock are taken.
> >
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > [clarification of commit message by plbossart]
> > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.c=
om>
> > Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> > Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> > Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> > Link: https://lore.kernel.org/r/20211207173745.15850-4-pierre-louis.bos=
sart@linux.intel.com
> > Cc: stable@vger.kernel.org # 5.15.x
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > ---
>
> What is the git commit id of this patch in Linus's tree?
>
> thanks,
>
> greg k-h

Hi Greg,
For this patch I think it is [3/6] b7898396f4bbe160f546d0c5e9fa17cca9a7d153

From https://lore.kernel.org/all/163953384515.1515253.13641477106348913835.=
b4-ty@kernel.org/
Seems there are total 6 patches.

[1/6] ASoC: soc-pcm: use GFP_ATOMIC for dpcm structure
      commit: d8a9c6e1f6766a16cf02b4e99a629f3c5512c183
[2/6] ASoC: soc-pcm: align BE 'atomicity' with that of the FE
      commit: bbf7d3b1c4f40eb02dd1dffb500ba00b0bff0303
[3/6] ASoC: soc-pcm: Fix and cleanup DPCM locking
      commit: b7898396f4bbe160f546d0c5e9fa17cca9a7d153
[4/6] ASoC: soc-pcm: serialize BE triggers
      commit: b2ae80663008a7662febe7d13f14ea1b2eb0cd51
[5/6] ASoC: soc-pcm: test refcount before triggering
      commit: 848aedfdc6ba25ad5652797db9266007773e44dd
[6/6] ASoC: soc-pcm: fix BE handling of PAUSE_RELEASE
      commit: 3aa1e96a2b95e2ece198f8dd01e96818971b84df

These 6 patches could directly cherry-pick to in 5.15 without conflict.
