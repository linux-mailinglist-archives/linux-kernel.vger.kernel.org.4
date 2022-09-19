Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038695BCE83
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiISOXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiISOXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:23:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD361D316;
        Mon, 19 Sep 2022 07:23:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28E7060F99;
        Mon, 19 Sep 2022 14:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF54C433D6;
        Mon, 19 Sep 2022 14:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663597397;
        bh=xAXpMxzhf05DluLv9kt1Z+WNwGCnPN4/sB59r5Fk8Cc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hSjT0eoARBaIUmrOLw2ndp7SKETRnmvUQfb2+e8VoOCf8TqiFNuBDQpwvpcIEb6p/
         wRfznQ8yiYDhLCajrnZxevDfZtGOTHskcXDG8JkGDcBqCs0TDI8CWJHJYLAmpk1xK6
         aSNKuq3uP/75k/6khX29YG+IriZUjgs0Ir1UNf74mQUoCFugM7Ndm9khUucj//6xPl
         0aGOYhkeNJih/buge9x8Hol3rstNHqi6KlU9Wb/kx9ABVpkaVJqwKwxzlbg+rKwWKa
         cNIv65TvM0W7CNniEO9xjmVo8I7PHEaHJnmPvr1ZKnaBRkuK/ZQPLaOBf9s9H3hu4m
         C1Z+5YaxmHVQw==
Date:   Mon, 19 Sep 2022 07:23:15 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@redhat.com>,
        DRI <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: Re: linux-next: manual merge of the drm tree with Linus' tree
Message-ID: <Yyh7U/QgJXmOr6Ff@dev-arch.thelio-3990X>
References: <20220919105839.496f1b72@canb.auug.org.au>
 <CAMuHMdVQmG6hjyw0g8L2AAuUSoQ9xH=C9zrV=QUoVWp_HM62BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVQmG6hjyw0g8L2AAuUSoQ9xH=C9zrV=QUoVWp_HM62BQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Mon, Sep 19, 2022 at 09:58:01AM +0200, Geert Uytterhoeven wrote:
> Hi Stephen,
> 
> On Mon, Sep 19, 2022 at 3:07 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > Today's linux-next merge of the drm tree got a conflict in:
> >
> >   drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> >
> > between commit:
> >
> >   41012d715d5d ("drm/amd/display: Mark dml30's UseMinimumDCFCLK() as noinline for stack usage")
> >
> > from Linus' tree and commit:
> >
> >   a0f7e7f759cf ("drm/amd/display: fix i386 frame size warning")
> >
> > from the drm tree.
> >
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> >
> > --
> > Cheers,
> > Stephen Rothwell
> >
> > diff --cc drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> > index 1cb858dd6ea0,b7fa003ffe06..000000000000
> > --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> > @@@ -6610,66 -6497,11 +6497,11 @@@ static double CalculateUrgentLatency
> >         return ret;
> >   }
> >
> >  -static void UseMinimumDCFCLK(
> >  +static noinline_for_stack void UseMinimumDCFCLK(
> 
> While this looks like the correct merge resolution, it does mean that
> both stack size mitigations are now applied, and probably one of them
> can be dropped?

Thanks for taking a look! As I note in the commit message of
41012d715d5d:

"Commit a0f7e7f759cf ("drm/amd/display: fix i386 frame size warning")
aimed to address this for i386 but it did not help x86_64.

... The aforementioned change does help reduce UseMinimumDCFCLK()'s
stack usage so it should not be reverted in favor of this change."

While it is possible that 41012d715d5d fixes the warning for both 32-bit
and 64-bit x86 (I did not check), a0f7e7f759cf is still a good change in
my opinion so neither should be reverted.

Cheers,
Nathan

> >                 struct display_mode_lib *mode_lib,
> > -               int MaxInterDCNTileRepeaters,
> > +               struct vba_vars_st *v,
> >                 int MaxPrefetchMode,
> > -               double FinalDRAMClockChangeLatency,
> > -               double SREnterPlusExitTime,
> > -               int ReturnBusWidth,
> > -               int RoundTripPingLatencyCycles,
> > -               int ReorderingBytes,
> > -               int PixelChunkSizeInKByte,
> > -               int MetaChunkSize,
> > -               bool GPUVMEnable,
> > -               int GPUVMMaxPageTableLevels,
> > -               bool HostVMEnable,
> > -               int NumberOfActivePlanes,
> > -               double HostVMMinPageSize,
> > -               int HostVMMaxNonCachedPageTableLevels,
> > -               bool DynamicMetadataVMEnabled,
> > -               enum immediate_flip_requirement ImmediateFlipRequirement,
> > -               bool ProgressiveToInterlaceUnitInOPP,
> > -               double MaxAveragePercentOfIdealSDPPortBWDisplayCanUseInNormalSystemOperation,
> > -               double PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelMixedWithVMData,
> > -               double PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyVMDataOnly,
> > -               double PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelDataOnly,
> > -               int VTotal[],
> > -               int VActive[],
> > -               int DynamicMetadataTransmittedBytes[],
> > -               int DynamicMetadataLinesBeforeActiveRequired[],
> > -               bool Interlace[],
> > -               double RequiredDPPCLK[][2][DC__NUM_DPP__MAX],
> > -               double RequiredDISPCLK[][2],
> > -               double UrgLatency[],
> > -               unsigned int NoOfDPP[][2][DC__NUM_DPP__MAX],
> > -               double ProjectedDCFCLKDeepSleep[][2],
> > -               double MaximumVStartup[][2][DC__NUM_DPP__MAX],
> > -               double TotalVActivePixelBandwidth[][2],
> > -               double TotalVActiveCursorBandwidth[][2],
> > -               double TotalMetaRowBandwidth[][2],
> > -               double TotalDPTERowBandwidth[][2],
> > -               unsigned int TotalNumberOfActiveDPP[][2],
> > -               unsigned int TotalNumberOfDCCActiveDPP[][2],
> > -               int dpte_group_bytes[],
> > -               double PrefetchLinesY[][2][DC__NUM_DPP__MAX],
> > -               double PrefetchLinesC[][2][DC__NUM_DPP__MAX],
> > -               unsigned int swath_width_luma_ub_all_states[][2][DC__NUM_DPP__MAX],
> > -               unsigned int swath_width_chroma_ub_all_states[][2][DC__NUM_DPP__MAX],
> > -               int BytePerPixelY[],
> > -               int BytePerPixelC[],
> > -               int HTotal[],
> > -               double PixelClock[],
> > -               double PDEAndMetaPTEBytesPerFrame[][2][DC__NUM_DPP__MAX],
> > -               double DPTEBytesPerRow[][2][DC__NUM_DPP__MAX],
> > -               double MetaRowBytes[][2][DC__NUM_DPP__MAX],
> > -               bool DynamicMetadataEnable[],
> > -               double VActivePixelBandwidth[][2][DC__NUM_DPP__MAX],
> > -               double VActiveCursorBandwidth[][2][DC__NUM_DPP__MAX],
> > -               double ReadBandwidthLuma[],
> > -               double ReadBandwidthChroma[],
> > -               double DCFCLKPerState[],
> > -               double DCFCLKState[][2])
> > +               int ReorderingBytes)
> >   {
> >         double   NormalEfficiency = 0;
> >         double   PTEEfficiency = 0;
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
