Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DB367C563
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 09:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbjAZIB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 03:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236265AbjAZIBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:01:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A4366F98;
        Thu, 26 Jan 2023 00:01:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CD47B81D00;
        Thu, 26 Jan 2023 08:01:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CDCC433EF;
        Thu, 26 Jan 2023 08:01:47 +0000 (UTC)
Message-ID: <e48e760a-e876-5640-77ee-44e209525dbf@xs4all.nl>
Date:   Thu, 26 Jan 2023 09:01:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 3/6] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver user interace
Content-Language: en-US
To:     yuji2.ishikawa@toshiba.co.jp, laurent.pinchart@ideasonboard.com,
        mchehab@kernel.org, nobuhiro1.iwamatsu@toshiba.co.jp,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rafael.j.wysocki@intel.com, broonie@kernel.org
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230111022433.25950-1-yuji2.ishikawa@toshiba.co.jp>
 <20230111022433.25950-4-yuji2.ishikawa@toshiba.co.jp>
 <2b412539-2236-b41f-c777-bc9e9cf99d66@xs4all.nl>
 <TYAPR01MB6201EF1A4BC17DA02128052E92CF9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <TYAPR01MB6201EF1A4BC17DA02128052E92CF9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2023 02:25, yuji2.ishikawa@toshiba.co.jp wrote:
> Hello Hans,
> 
> Thank you for your comments.
> 
>> -----Original Message-----
>> From: Hans Verkuil <hverkuil@xs4all.nl>
>> Sent: Tuesday, January 17, 2023 8:47 PM
>> To: ishikawa yuji(石川 悠司 ○ＲＤＣ□ＡＩＴＣ○ＥＡ開)
>> <yuji2.ishikawa@toshiba.co.jp>; Laurent Pinchart
>> <laurent.pinchart@ideasonboard.com>; Mauro Carvalho Chehab
>> <mchehab@kernel.org>; iwamatsu nobuhiro(岩松 信洋 □ＳＷＣ◯ＡＣＴ)
>> <nobuhiro1.iwamatsu@toshiba.co.jp>; Rob Herring <robh+dt@kernel.org>;
>> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Rafael J . Wysocki
>> <rafael.j.wysocki@intel.com>; Mark Brown <broonie@kernel.org>
>> Cc: linux-media@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
>> Subject: Re: [PATCH v5 3/6] media: platform: visconti: Add Toshiba Visconti
>> Video Input Interface driver user interace
>>
>> More comments below:
>>
>> On 11/01/2023 03:24, Yuji Ishikawa wrote:
>>> Add support to Video Input Interface on Toshiba Visconti ARM SoCs.
>>> The interface device includes CSI2 Receiver,
>>> frame grabber, video DMAC and image signal processor.
>>> This patch provides the user interface layer.
>>>
>>> A driver instance provides three /dev/videoX device files;
>>> one for RGB image capture, another one for optional RGB capture
>>> with different parameters and the last one for RAW capture.
>>>
>>> Through the device files, the driver provides streaming (DMA-BUF) interface.
>>> A userland application should feed DMA-BUF instances for capture buffers.
>>>
>>> The driver is based on media controller framework.
>>> Its operations are roughly mapped to two subdrivers;
>>> one for ISP and CSI2 receiver (yields 1 instance),
>>> the other for capture (yields 3 instances for each capture mode).
>>>
>>> Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
>>> ---
>>> Changelog v2:
>>> - Resend v1 because a patch exceeds size limit.
>>>
>>> Changelog v3:
>>> - Adapted to media control framework
>>> - Introduced ISP subdevice, capture device
>>> - Remove private IOCTLs and add vendor specific V4L2 controls
>>> - Change function name avoiding camelcase and uppercase letters
>>>
>>> Changelog v4:
>>> - Split patches because the v3 patch exceeds size limit
>>> - Stop using ID number to identify driver instance:
>>>   - Use dynamically allocated structure to hold HW specific context,
>>>     instead of static one.
>>>   - Call HW layer functions with the context structure instead of ID number
>>> - Use pm_runtime to trigger initialization of HW
>>>   along with open/close of device files.
>>>
>>> Changelog v5:
>>> - Fix coding style problems in viif.c
>>> ---
>>>  drivers/media/platform/visconti/Makefile      |    1 +
>>>  drivers/media/platform/visconti/viif.c        |  545 ++++++++
>>>  drivers/media/platform/visconti/viif.h        |  203 +++
>>>  .../media/platform/visconti/viif_capture.c    | 1201
>> +++++++++++++++++
>>>  drivers/media/platform/visconti/viif_isp.c    |  846 ++++++++++++
>>>  5 files changed, 2796 insertions(+)
>>>  create mode 100644 drivers/media/platform/visconti/viif.c
>>>  create mode 100644 drivers/media/platform/visconti/viif.h
>>>  create mode 100644 drivers/media/platform/visconti/viif_capture.c
>>>  create mode 100644 drivers/media/platform/visconti/viif_isp.c
>>>

<snip>

>>> +static int viif_g_selection(struct file *file, void *priv, struct v4l2_selection *s)
>>> +{
>>> +	struct cap_dev *cap_dev = video_drvdata_to_capdev(file);
>>> +	struct viif_device *viif_dev = cap_dev->viif_dev;
>>> +	struct v4l2_subdev_selection sel = {
>>> +		.target = V4L2_SEL_TGT_CROP,
>>> +		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
>>> +	};
>>> +	int ret;
>>> +
>>
>> This is missing validation checks for s->type and s->target.
> 
> I'll add validation code.
> 
>> I've pretty sure you didn't run the v4l2-compliance utility: that would have
>> failed on this.
> 
> Sorry I didn't know the utility.
> I'll apply it.

FYI: v4l2-compliance is part of the v4l-utils git repo.

Build it from scratch:

git clone git://linuxtv.org/v4l-utils.git
cd v4l-utils
./bootstrap.sh
./configure
make
sudo make install

> 
>>> +	/* check path id */
>>> +	if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST0)
>>> +		sel.pad = VIIF_ISP_PAD_SRC_PATH0;
>>> +	else if (cap_dev->pathid == CAPTURE_PATH_MAIN_POST1)
>>> +		sel.pad = VIIF_ISP_PAD_SRC_PATH1;
>>> +	else
>>> +		return -EINVAL;
>>> +
>>> +	ret = v4l2_subdev_call(&viif_dev->isp_subdev.sd, pad, get_selection,
>> NULL, &sel);
>>> +	s->r = sel.r;
>>> +
>>> +	return ret;
>>> +}

<snip>

>>> +/* ----- register/remove capture device node ----- */
>>> +static int visconti_viif_capture_register_node(struct cap_dev *cap_dev)
>>> +{
>>> +	struct viif_device *viif_dev = cap_dev->viif_dev;
>>> +	struct v4l2_device *v4l2_dev = &viif_dev->v4l2_dev;
>>> +	struct video_device *vdev = &cap_dev->vdev;
>>> +	struct vb2_queue *q = &cap_dev->vb2_vq;
>>> +	static const char *const node_name[] = {
>>> +		"viif_capture_post0",
>>> +		"viif_capture_post1",
>>> +		"viif_capture_sub",
>>> +	};
>>> +	int ret;
>>> +
>>> +	INIT_LIST_HEAD(&cap_dev->buf_queue);
>>> +
>>> +	mutex_init(&cap_dev->vlock);
>>> +
>>> +	/* Initialize vb2 queue. */
>>> +	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
>>> +	q->io_modes = VB2_DMABUF;
>>
>> Why is there no VB2_MMAP?
> 
> The hardware requests physically contiguous memory for frame buffer.
> I'm not sure if memory allocation in VB2_MMAP mode satisfies this restriction.

Yes, it does.

> 
>>> +	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
>>> +	q->ops = &viif_vb2_ops;
>>> +	q->mem_ops = &vb2_dma_contig_memops;

The use of vb2_dma_contig_memops is what enforces physically contiguous memory.
It works fine with VB2_MMAP.

>>> +	q->drv_priv = cap_dev;
>>> +	q->buf_struct_size = sizeof(struct viif_buffer);
>>> +	q->min_buffers_needed = 2;
>>> +	q->lock = &cap_dev->vlock;
>>> +	q->dev = viif_dev->v4l2_dev.dev;
>>> +
>>> +	ret = vb2_queue_init(q);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	/* Register the video device. */
>>> +	strscpy(vdev->name, node_name[cap_dev->pathid],
>> sizeof(vdev->name));
>>> +	vdev->v4l2_dev = v4l2_dev;
>>> +	vdev->lock = &cap_dev->vlock;
>>> +	vdev->queue = &cap_dev->vb2_vq;
>>> +	vdev->ctrl_handler = NULL;
>>> +	vdev->fops = &viif_fops;
>>> +	vdev->ioctl_ops = &viif_ioctl_ops;
>>> +	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE_MPLANE |
>> V4L2_CAP_STREAMING;
>>> +	vdev->device_caps |= V4L2_CAP_IO_MC;
>>> +	vdev->entity.ops = &viif_media_ops;
>>> +	vdev->release = video_device_release_empty;
>>> +	video_set_drvdata(vdev, cap_dev);
>>> +	vdev->vfl_dir = VFL_DIR_RX;
>>> +	cap_dev->capture_pad.flags = MEDIA_PAD_FL_SINK;
>>> +
>>> +	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
>>> +	if (ret < 0) {
>>> +		dev_err(v4l2_dev->dev, "video_register_device failed: %d\n",
>> ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	ret = media_entity_pads_init(&vdev->entity, 1,
>> &cap_dev->capture_pad);
>>> +	if (ret) {
>>> +		video_unregister_device(vdev);
>>> +		return ret;
>>> +	}
>>> +
>>> +	ret = v4l2_ctrl_handler_init(&cap_dev->ctrl_handler, 30);
>>> +	if (ret)
>>> +		return -ENOMEM;
>>> +
>>> +	cap_dev->vdev.ctrl_handler = &cap_dev->ctrl_handler;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +int visconti_viif_capture_register(struct viif_device *viif_dev)
>>> +{
>>> +	int ret;
>>> +
>>> +	/* register MAIN POST0 (primary RGB output)*/
>>> +	viif_dev->cap_dev0.pathid = CAPTURE_PATH_MAIN_POST0;
>>> +	viif_dev->cap_dev0.viif_dev = viif_dev;
>>> +	ret = visconti_viif_capture_register_node(&viif_dev->cap_dev0);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	/* register MAIN POST1 (additional RGB output)*/
>>> +	viif_dev->cap_dev1.pathid = CAPTURE_PATH_MAIN_POST1;
>>> +	viif_dev->cap_dev1.viif_dev = viif_dev;
>>> +	ret = visconti_viif_capture_register_node(&viif_dev->cap_dev1);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	/* register SUB (RAW output) */
>>> +	viif_dev->cap_dev2.pathid = CAPTURE_PATH_SUB;
>>> +	viif_dev->cap_dev2.viif_dev = viif_dev;
>>> +	ret = visconti_viif_capture_register_node(&viif_dev->cap_dev2);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void visconti_viif_capture_unregister_node(struct cap_dev *cap_dev)
>>> +{
>>> +	media_entity_cleanup(&cap_dev->vdev.entity);
>>> +	v4l2_ctrl_handler_free(&cap_dev->ctrl_handler);
>>> +	vb2_video_unregister_device(&cap_dev->vdev);
>>> +	mutex_destroy(&cap_dev->vlock);
>>> +}
>>> +
>>> +void visconti_viif_capture_unregister(struct viif_device *viif_dev)
>>> +{
>>> +	visconti_viif_capture_unregister_node(&viif_dev->cap_dev0);
>>> +	visconti_viif_capture_unregister_node(&viif_dev->cap_dev1);
>>> +	visconti_viif_capture_unregister_node(&viif_dev->cap_dev2);
>>> +}

Regards,

	Hans

