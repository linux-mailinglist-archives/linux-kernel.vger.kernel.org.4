Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598E16AD8E7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjCGIOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjCGIOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:14:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9152CFDC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 00:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678176801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eaDyYxdl8H5MCNMn5TQI1yfFN1klSnZ3ERr+2rNfpwQ=;
        b=f0ZU6ShneMPGXG63r1w7KaaF4vOVCqYQgQqE9bpkvz7PeoqS57PqRXDjsbzl3vEGrOCvXu
        D7wKZgj+xpQ8Cwn3GdEvt6pPX1P97I50JsAOUmqBJE4knW3rRv2ogAjT/5x8mJtSBLvtTQ
        rdtJWlUY8/kTSdSDGu+/OLkDrNBax+c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-xPCSS5i9MuWU4N6eGw65_A-1; Tue, 07 Mar 2023 03:13:20 -0500
X-MC-Unique: xPCSS5i9MuWU4N6eGw65_A-1
Received: by mail-wr1-f71.google.com with SMTP id x3-20020a5d6503000000b002c8c421fdfaso1969758wru.15
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 00:13:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678176799;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eaDyYxdl8H5MCNMn5TQI1yfFN1klSnZ3ERr+2rNfpwQ=;
        b=vjGilVL5h/ebFC24+HOzh35niXm1rhCadXQarSwG2+RGTlcLdKEqH1GH7KFsu3rx//
         enTnaeqz0MbzaEs6QNyrFVVWzIS1fFZtjwFZVWuvpiG7atBU2TmV9fwq1J/t8zmOS8jH
         Ht/Xs9KMLjfi8McwE7++vc/IVE+C4uCP7nJSsJ8aBspcCSnUcv8sxXrV8SCFApLzhB93
         n/a+ZwGjG2t2DCzjMgXFFIoJJFt5AZk8/qaD9ELoYYUaF0ymowrigxa41qp8nCSXwktq
         /hqPC7cnPo+07/RheZpUKTLguf3aW7ijD0PKDfnPpEvA22JypHDQiWv+UxqdjteXkUsq
         9w3A==
X-Gm-Message-State: AO0yUKWX02+2tAe8MV2YDlRx/MWTcZJkYQINfvF9ewjW32uh3K3hlQMQ
        xb/8B3ViDt1UY53HFhFWhjVB0d/9Bk5MLKOvYwGrkQv/t/gWlntArSxyr4ipbsqlysoIurqYYZO
        8AzqxI5GwYbXaK8ypJiSyNJgL
X-Received: by 2002:a05:600c:1c96:b0:3eb:3300:1d13 with SMTP id k22-20020a05600c1c9600b003eb33001d13mr11814552wms.14.1678176799078;
        Tue, 07 Mar 2023 00:13:19 -0800 (PST)
X-Google-Smtp-Source: AK7set/3pDAfxNUSHlkpssOCT65mbRgtyryaXs9mLdFkCSnDjoJ7oHIx91gGlBecogb8xOq+P40u8Q==
X-Received: by 2002:a05:600c:1c96:b0:3eb:3300:1d13 with SMTP id k22-20020a05600c1c9600b003eb33001d13mr11814526wms.14.1678176798781;
        Tue, 07 Mar 2023 00:13:18 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c351100b003e4326a6d53sm17330660wmq.35.2023.03.07.00.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 00:13:18 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Jordan Crouse <jorcrous@amazon.com>
Cc:     linux-kernel@vger.kernel.org, Albert Esteve <aesteve@redhat.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Sergio Lopez <slp@redhat.com>,
        Enric Balletbo i Serra <eballetb@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH] media: venus: dec: Fix capture formats enumeration order
In-Reply-To: <3d0315fa-14ca-dc34-81ae-467d9ed5133d@quicinc.com>
References: <20230210081835.2054482-1-javierm@redhat.com>
 <20230303220918.qr5ydbin3nye3qtz@amazon.com>
 <87h6uydwel.fsf@minerva.mail-host-address-is-not-set>
 <3d0315fa-14ca-dc34-81ae-467d9ed5133d@quicinc.com>
Date:   Tue, 07 Mar 2023 09:13:16 +0100
Message-ID: <87sfeh0yjn.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dikshita Agarwal <quic_dikshita@quicinc.com> writes:

Hello Dikshita,

> On 3/6/2023 3:38 PM, Javier Martinez Canillas wrote:
>> Jordan Crouse <jorcrous@amazon.com> writes:
>>
>> Hello Jordan,
>>
>>> On Fri, Feb 10, 2023 at 09:18:35AM +0100, Javier Martinez Canillas wrote:
>>>> Commit 9593126dae3e ("media: venus: Add a handling of QC08C compressed
>>>> format") and commit cef92b14e653 ("media: venus: Add a handling of QC10C
>>>> compressed format") added support for the QC08C and QC10C compressed
>>>> formats respectively.
>>>>
>>>> But these also caused a regression, because the new formats where added
>>>> at the beginning of the vdec_formats[] array and the vdec_inst_init()
>>>> function sets the default format output and capture using fixed indexes
>>>> of that array:
>>>>
>>>> static void vdec_inst_init(struct venus_inst *inst)
>>>> {
>>>> ...
>>>> 	inst->fmt_out = &vdec_formats[8];
>>>> 	inst->fmt_cap = &vdec_formats[0];
>>>> ...
>>>> }
>>>>
>>>> Since now V4L2_PIX_FMT_NV12 is not the first entry in the array anymore,
>>>> the default capture format is not set to that as it was done before.
>>>>
>>>> Both commits changed the first index to keep inst->fmt_out default format
>>>> set to V4L2_PIX_FMT_H264, but did not update the latter to keep .fmt_out
>>>> default format set to V4L2_PIX_FMT_NV12.
>>>>
>>>> Rather than updating the index to the current V4L2_PIX_FMT_NV12 position,
>>>> let's reorder the entries so that this format is the first entry again.
>>>>
>>>> This would also make VIDIOC_ENUM_FMT report the V4L2_PIX_FMT_NV12 format
>>>> with an index 0 as it did before the QC08C and QC10C formats were added.
>>>>
>>>> Fixes: 9593126dae3e ("media: venus: Add a handling of QC08C compressed format")
>>>> Fixes: cef92b14e653 ("media: venus: Add a handling of QC10C compressed format")
>>>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>>> I just came across this issue independently and can confirm this patch fixes
>>> the GStreamer V4L2 decoder on QRB5165.
>>>
>>> Tested-by: Jordan Crouse <jorcrous@amazon.com>
>>>
>> Thanks for testing it!
>>
>> Stanimir, can we please get this for v6.3 as well?
>
> Hi Javier, Jordan
>
> Could you please explain what regression/issue you see with patch?
>
> venus hardware supports QC08C which provides better performance hence 
> driver is publishing it as preferred color format.
>
> if client doesn't support this or want to use any other format, they can 
> set the desired format with s_fmt.
>

VIDIOC_S_FMT is currently broken for venus, at least on the HP X2
Chromebook and only the default works. I'm still investigating why
vdec_s_fmt() is not working.

But basically, if VIDIOC_S_FMT is called for the capture queue,
then later the VIDIOC_G_FMT ioctl fails with -EINVAL. This is due
the following condition checked in vdec_check_src_change():

static int vdec_check_src_change(struct venus_inst *inst)
{
...
	if (inst->subscriptions & V4L2_EVENT_SOURCE_CHANGE &&
	    inst->codec_state == VENUS_DEC_STATE_INIT &&
	    !inst->reconfig)
		return -EINVAL;
...
}

But regardless, I think that it would be better for a driver to
not change the order of advertised VIDIOC_ENUM_FMT pixel formats.

Because what happens now is that a decoding that was previously
working by default is not working anymore due a combination of
the default being changed and S_FMT not working as expected.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

