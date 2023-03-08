Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B7C6B10CB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 19:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjCHSNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 13:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjCHSNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 13:13:15 -0500
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF0112BD2;
        Wed,  8 Mar 2023 10:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1678299177; x=1709835177;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject;
  bh=XPPM5cG1Lc8BsmZVegn83SYjFbU765xkniaab9xstAw=;
  b=jsk9bG+VLj4zCW4VEQsLkiOpSb2Qd9yvoC/OgmmCSXxI71Yx/2efhxp0
   FDQS66VRqB71d2mD1yQL4i6xkyRMsWF26WJq7nIjNvfvFlDDMHhpwVGTJ
   jc1328bvQ2vgpMldNN3WeP+NTOrCTMMYMS22k8uTmpMonMMB0ipuLB4y+
   U=;
X-IronPort-AV: E=Sophos;i="5.98,244,1673913600"; 
   d="scan'208";a="268068705"
Subject: Re: [PATCH] media: venus: dec: Fix capture formats enumeration order
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-366646a6.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 18:12:55 +0000
Received: from EX13MTAUWB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-m6i4x-366646a6.us-east-1.amazon.com (Postfix) with ESMTPS id 97F6DA2702;
        Wed,  8 Mar 2023 18:12:49 +0000 (UTC)
Received: from EX19D047UWB002.ant.amazon.com (10.13.138.34) by
 EX13MTAUWB002.ant.amazon.com (10.43.161.202) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Wed, 8 Mar 2023 18:12:48 +0000
Received: from amazon.com (10.187.170.17) by EX19D047UWB002.ant.amazon.com
 (10.13.138.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.24; Wed, 8 Mar
 2023 18:12:47 +0000
Date:   Wed, 8 Mar 2023 11:12:45 -0700
From:   Jordan Crouse <jorcrous@amazon.com>
To:     Enric Balletbo i Serra <eballetb@redhat.com>
CC:     Javier Martinez Canillas <javierm@redhat.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        <linux-kernel@vger.kernel.org>, Albert Esteve <aesteve@redhat.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Sergio Lopez <slp@redhat.com>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-media@vger.kernel.org>
Message-ID: <20230308181245.nbnwkdtdnsldd65l@amazon.com>
References: <20230210081835.2054482-1-javierm@redhat.com>
 <20230303220918.qr5ydbin3nye3qtz@amazon.com>
 <87h6uydwel.fsf@minerva.mail-host-address-is-not-set>
 <3d0315fa-14ca-dc34-81ae-467d9ed5133d@quicinc.com>
 <87sfeh0yjn.fsf@minerva.mail-host-address-is-not-set>
 <CALE0LRvR=DjUp2_DBuPQkEr9jvzGH4Mx4-7=rc6zOw1APQdyeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALE0LRvR=DjUp2_DBuPQkEr9jvzGH4Mx4-7=rc6zOw1APQdyeQ@mail.gmail.com>
X-Originating-IP: [10.187.170.17]
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D047UWB002.ant.amazon.com (10.13.138.34)
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 05:20:18PM +0100, Enric Balletbo i Serra wrote:
> Hi all,
> 
> On Tue, Mar 7, 2023 at 9:13 AM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
> >
> > Dikshita Agarwal <quic_dikshita@quicinc.com> writes:
> >
> > Hello Dikshita,
> >
> > > On 3/6/2023 3:38 PM, Javier Martinez Canillas wrote:
> > >> Jordan Crouse <jorcrous@amazon.com> writes:
> > >>
> > >> Hello Jordan,
> > >>
> > >>> On Fri, Feb 10, 2023 at 09:18:35AM +0100, Javier Martinez Canillas wrote:
> > >>>> Commit 9593126dae3e ("media: venus: Add a handling of QC08C compressed
> > >>>> format") and commit cef92b14e653 ("media: venus: Add a handling of QC10C
> > >>>> compressed format") added support for the QC08C and QC10C compressed
> > >>>> formats respectively.
> > >>>>
> > >>>> But these also caused a regression, because the new formats where added
> > >>>> at the beginning of the vdec_formats[] array and the vdec_inst_init()
> > >>>> function sets the default format output and capture using fixed indexes
> > >>>> of that array:
> > >>>>
> > >>>> static void vdec_inst_init(struct venus_inst *inst)
> > >>>> {
> > >>>> ...
> > >>>>    inst->fmt_out = &vdec_formats[8];
> > >>>>    inst->fmt_cap = &vdec_formats[0];
> > >>>> ...
> > >>>> }
> > >>>>
> > >>>> Since now V4L2_PIX_FMT_NV12 is not the first entry in the array anymore,
> > >>>> the default capture format is not set to that as it was done before.
> > >>>>
> > >>>> Both commits changed the first index to keep inst->fmt_out default format
> > >>>> set to V4L2_PIX_FMT_H264, but did not update the latter to keep .fmt_out
> > >>>> default format set to V4L2_PIX_FMT_NV12.
> > >>>>
> > >>>> Rather than updating the index to the current V4L2_PIX_FMT_NV12 position,
> > >>>> let's reorder the entries so that this format is the first entry again.
> > >>>>
> > >>>> This would also make VIDIOC_ENUM_FMT report the V4L2_PIX_FMT_NV12 format
> > >>>> with an index 0 as it did before the QC08C and QC10C formats were added.
> > >>>>
> > >>>> Fixes: 9593126dae3e ("media: venus: Add a handling of QC08C compressed format")
> > >>>> Fixes: cef92b14e653 ("media: venus: Add a handling of QC10C compressed format")
> > >>>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> > >>> I just came across this issue independently and can confirm this patch fixes
> > >>> the GStreamer V4L2 decoder on QRB5165.
> > >>>
> > >>> Tested-by: Jordan Crouse <jorcrous@amazon.com>
> > >>>
> 
> This patch also fixes an issue running a V4L2 based decoder on Acer
> Chromebook Spin 513 which is very similar to the HP X2 Chromebook, not
> surprising as both platforms are basically the same, but anyway:
> 
> Tested-by: Enric Balletbo i Serra <eballetbo@redhat.com>
> 
> >
> > >> Thanks for testing it!
> > >>
> > >> Stanimir, can we please get this for v6.3 as well?
> > >
> > > Hi Javier, Jordan
> > >
> > > Could you please explain what regression/issue you see with patch?
> > >
> > > venus hardware supports QC08C which provides better performance hence
> > > driver is publishing it as preferred color format.
> > >
> > > if client doesn't support this or want to use any other format, they can
> > > set the desired format with s_fmt.
> > >
> 
> I guess general clients are unlikely to support this format as it is
> an opaque intermediate format used by Qualcomm platforms, and the
> purpose of that format is to be used for other Qualcomm hardware
> blocks that know about this format. So I'd say that returning by
> default a more common format is more reliable. Using your argument if
> someone wants to use QC08C (because he knows it can use it) set with
> s_fmt will do the trick too.
> 
> In any case, the problem here seems to be that s_fmt is not working,
> so it would be nice to have a solution for that first and meanwhile do
> not change the old behaviour. Just my two cents.
> 
> Best regards,
>  Enric Balletbo
> 
> >
> > VIDIOC_S_FMT is currently broken for venus, at least on the HP X2
> > Chromebook and only the default works. I'm still investigating why
> > vdec_s_fmt() is not working.
> >
> > But basically, if VIDIOC_S_FMT is called for the capture queue,
> > then later the VIDIOC_G_FMT ioctl fails with -EINVAL. This is due
> > the following condition checked in vdec_check_src_change():
> >
> > static int vdec_check_src_change(struct venus_inst *inst)
> > {
> > ...
> >         if (inst->subscriptions & V4L2_EVENT_SOURCE_CHANGE &&
> >             inst->codec_state == VENUS_DEC_STATE_INIT &&
> >             !inst->reconfig)
> >                 return -EINVAL;
> > ...
> > }
> >
> > But regardless, I think that it would be better for a driver to
> > not change the order of advertised VIDIOC_ENUM_FMT pixel formats.
> >
> > Because what happens now is that a decoding that was previously
> > working by default is not working anymore due a combination of
> > the default being changed and S_FMT not working as expected.

For my part, I was using the gstreamer v4l2 decoder which for some reason tries
to verify it can support whatever format it gets with G_FMT *before*
trying a S_FMT. I can't confirm or deny if S_FMT currently works or not.

That said, I entirely agree with Javier. While it might be more
bandwidth efficient, QC08C is a obscure format. It is far more likely that the
average open source user would rather use a well known output format and, as
has been mentioned, once S_FMT is fixed those in the know can use the other
formats if they are working with other Qualcomm hardware blocks.

Jordan
