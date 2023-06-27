Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54ABD73F7A3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjF0Inm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjF0Ing (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:43:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A39FC;
        Tue, 27 Jun 2023 01:43:34 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:8022:d131:505c:c461] (unknown [IPv6:2a01:e0a:120:3210:8022:d131:505c:c461])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E42AA6607102;
        Tue, 27 Jun 2023 09:43:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687855413;
        bh=c0PGEBEliqWwx30S7I9VDw4FeXubEDDT0VRtcMq3mEI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Z4/6z2ozoJ6Jl1EtqZgNmcrwimmMYr7rTJc+xciE0Ua1byFGV/zhmIflGoiascrY9
         kMfOSKFrcCQAxFivNV4kELP4Cf3paLR5eAMxDViTYnBHp3j94HPeWmhLVE0dEGdRNz
         Xb73mDdspnKz9ZrGEqVoavOGkMEIVdX5JSggaIEpRXxldWTICdQEPzqIp6H98Ve4tK
         Llg3MhxmYjDgV77ndBuF+/qQI8QhtAYG1vBPbMTxUfAReL27RLQFqWe33Irqt8xWSl
         6V+cNTfNOb7oRovU/AM42B8DE2Hcn66nK4s8xMAWgdYe9WSw0DioT3hjx/iG6ks1R/
         ykOjVeYz/Ziow==
Message-ID: <42a45bad-09c7-ffb6-49cb-29ec0826599d@collabora.com>
Date:   Tue, 27 Jun 2023 10:43:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 10/11] media: v4l2: Add DELETE_BUF ioctl
To:     Hsia-Jun Li <Randy.Li@synaptics.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, ming.qian@nxp.com,
        hverkuil-cisco@xs4all.nl, gregkh@linuxfoundation.org,
        ezequiel@vanguardiasur.com.ar,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, nicolas.dufresne@collabora.com,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com
References: <20230622131349.144160-1-benjamin.gaignard@collabora.com>
 <20230622131349.144160-11-benjamin.gaignard@collabora.com>
 <80a03c29-6f3d-43f1-755c-10f3ae2c2756@synaptics.com>
Content-Language: en-US
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <80a03c29-6f3d-43f1-755c-10f3ae2c2756@synaptics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 27/06/2023 à 09:30, Hsia-Jun Li a écrit :
>
> On 6/22/23 21:13, Benjamin Gaignard wrote:
>> CAUTION: Email originated externally, do not click links or open 
>> attachments unless you recognize the sender and know the content is 
>> safe.
>>
>>
>> VIDIOC_DELETE_BUF ioctl allows to delete a buffer from a queue.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>>   .../userspace-api/media/v4l/user-func.rst     |  1 +
>>   .../media/v4l/vidioc-delete-buf.rst           | 51 +++++++++++++++++++
>>   .../media/common/videobuf2/videobuf2-core.c   | 33 ++++++++++++
>>   .../media/common/videobuf2/videobuf2-v4l2.c   |  6 +++
>>   drivers/media/v4l2-core/v4l2-dev.c            |  1 +
>>   drivers/media/v4l2-core/v4l2-ioctl.c          | 10 ++++
>>   include/media/v4l2-ioctl.h                    |  4 ++
>>   include/media/videobuf2-core.h                |  9 ++++
>>   include/media/videobuf2-v4l2.h                | 11 ++++
>>   include/uapi/linux/videodev2.h                |  2 +
>>   10 files changed, 128 insertions(+)
>>   create mode 100644 
>> Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
>>
>> diff --git a/Documentation/userspace-api/media/v4l/user-func.rst 
>> b/Documentation/userspace-api/media/v4l/user-func.rst
>> index 15ff0bf7bbe6..8c74016e12fd 100644
>> --- a/Documentation/userspace-api/media/v4l/user-func.rst
>> +++ b/Documentation/userspace-api/media/v4l/user-func.rst
>> @@ -17,6 +17,7 @@ Function Reference
>>       vidioc-dbg-g-chip-info
>>       vidioc-dbg-g-register
>>       vidioc-decoder-cmd
>> +    vidioc-delete-buf
>>       vidioc-dqevent
>>       vidioc-dv-timings-cap
>>       vidioc-encoder-cmd
>> diff --git 
>> a/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst 
>> b/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
>> new file mode 100644
>> index 000000000000..0e7ce58f91bc
>> --- /dev/null
>> +++ b/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
>> @@ -0,0 +1,51 @@
>> +.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
>> +.. c:namespace:: V4L
>> +
>> +.. _VIDIOC_DELETE_BUF:
>> +
>> +************************
>> +ioctl VIDIOC_DELETE_BUF
>> +************************
>> +
>> +Name
>> +====
>> +
>> +VIDIOC_DELETE_BUF - Delete a buffer from a queue
>> +
>> +Synopsis
>> +========
>> +
>> +.. c:macro:: VIDIOC_DELETE_BUF
>> +
>> +``int ioctl(int fd, VIDIOC_DELETE_BUF, struct v4l2_buffer *argp)``
>> +
>> +Arguments
>> +=========
>> +
>> +``fd``
>> +    File descriptor returned by :c:func:`open()`.
>> +
>> +``argp``
>> +    Pointer to struct :c:type:`v4l2_buffer`.
>> +
>> +Description
>> +===========
>> +
>> +Applications can optionally call the :ref:`VIDIOC_DELETE_BUF` ioctl to
>> +delete a buffer from a queue.
>> +
>> +The struct :c:type:`v4l2_buffer` structure is specified in
>> +:ref:`buffer`.
>> +
>> +Return Value
>> +============
>> +
>> +On success 0 is returned, on error -1 and the ``errno`` variable is set
>> +appropriately. The generic error codes are described at the
>> +:ref:`Generic Error Codes <gen-errors>` chapter.
>> +
>> +EBUSY
>> +    File I/O is in progress.
>> +
>> +EINVAL
>> +    The buffer ``index`` doesn't exist in the queue.
>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c 
>> b/drivers/media/common/videobuf2/videobuf2-core.c
>> index 899783f67580..aa546c972c3d 100644
>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>> @@ -1637,6 +1637,39 @@ int vb2_core_prepare_buf(struct vb2_queue *q, 
>> unsigned int index, void *pb)
>>   }
>>   EXPORT_SYMBOL_GPL(vb2_core_prepare_buf);
>>
>> +int vb2_core_delete_buf(struct vb2_queue *q, unsigned int index)
>> +{
>> +       struct vb2_buffer *vb;
>> +
>> +       vb = vb2_get_buffer(q, index);
>> +       if (!vb) {
>> +               dprintk(q, 1, "invalid buffer index %d\n", index);
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (vb->state != VB2_BUF_STATE_DEQUEUED) {
>> +               dprintk(q, 1, "can't delete non dequeued buffer index 
>> %d\n", index);
>> +               return -EINVAL;
>> +       }
>> +
> I know the driver could implement its own 
> v4l2_ioctl_ops->vidioc_delete_buf() that check whether a buffer is 
> used by the hardware as a future reference frame.
> But I think we need a flag to let the user know which buffer is still 
> used by the hardware.
> Alternative ref case is safe, we only know it's existing when it is 
> dequeued in current V4L2 buffer mechanism.
> While the Golden reference frame, such long term reference frame could 
> last much longer.

It is up to userland stack to know frames life time, it got the information for that.

>> +       if (vb->planes[0].mem_priv)
>> +               call_void_vb_qop(vb, buf_cleanup, vb);
>> +
>> +       /* Free MMAP buffers or release USERPTR buffers */
>> +       if (q->memory == VB2_MEMORY_MMAP)
>> +               __vb2_buf_mem_free(vb);
>> +       else if (q->memory == VB2_MEMORY_DMABUF)
>> +               __vb2_buf_dmabuf_put(vb);
>> +       else
>> +               __vb2_buf_userptr_put(vb);
>> +
>> +       vb2_queue_remove_buffer(q, vb);
>> +       kfree(vb);
>> +
>> +       dprintk(q, 2, "buffer %d deleted\n", index);
>> +       return 0;
>> +}
>> +
>>   /*
>>    * vb2_start_streaming() - Attempt to start streaming.
>>    * @q:         videobuf2 queue
>> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c 
>> b/drivers/media/common/videobuf2/videobuf2-v4l2.c
>> index 724135d41f7f..cea666c17b41 100644
>> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
>> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
>> @@ -751,6 +751,12 @@ int vb2_prepare_buf(struct vb2_queue *q, struct 
>> media_device *mdev,
>>   }
>>   EXPORT_SYMBOL_GPL(vb2_prepare_buf);
>>
>> +int vb2_delete_buf(struct vb2_queue *q, struct v4l2_buffer *b)
>> +{
>> +       return vb2_core_delete_buf(q, b->index);
>> +}
>> +EXPORT_SYMBOL_GPL(vb2_delete_buf);
>> +
>>   int vb2_create_bufs(struct vb2_queue *q, struct v4l2_create_buffers 
>> *create)
>>   {
>>          unsigned requested_planes = 1;
>> diff --git a/drivers/media/v4l2-core/v4l2-dev.c 
>> b/drivers/media/v4l2-core/v4l2-dev.c
>> index f81279492682..80ace2e1e932 100644
>> --- a/drivers/media/v4l2-core/v4l2-dev.c
>> +++ b/drivers/media/v4l2-core/v4l2-dev.c
>> @@ -720,6 +720,7 @@ static void determine_valid_ioctls(struct 
>> video_device *vdev)
>>                  SET_VALID_IOCTL(ops, VIDIOC_PREPARE_BUF, 
>> vidioc_prepare_buf);
>>                  SET_VALID_IOCTL(ops, VIDIOC_STREAMON, vidioc_streamon);
>>                  SET_VALID_IOCTL(ops, VIDIOC_STREAMOFF, 
>> vidioc_streamoff);
>> +               SET_VALID_IOCTL(ops, VIDIOC_DELETE_BUF, 
>> vidioc_delete_buf);
>>          }
>>
>>          if (is_vid || is_vbi || is_meta) {
>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c 
>> b/drivers/media/v4l2-core/v4l2-ioctl.c
>> index a858acea6547..1c737279d3ef 100644
>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
>> @@ -2156,6 +2156,15 @@ static int v4l_prepare_buf(const struct 
>> v4l2_ioctl_ops *ops,
>>          return ret ? ret : ops->vidioc_prepare_buf(file, fh, b);
>>   }
>>
>> +static int v4l_delete_buf(const struct v4l2_ioctl_ops *ops,
>> +                         struct file *file, void *fh, void *arg)
>> +{
>> +       struct v4l2_buffer *b = arg;
>> +       int ret = check_fmt(file, b->type);
>> +
>> +       return ret ? ret : ops->vidioc_delete_buf(file, fh, b);
>> +}
>> +
>>   static int v4l_g_parm(const struct v4l2_ioctl_ops *ops,
>>                                  struct file *file, void *fh, void *arg)
>>   {
>> @@ -2905,6 +2914,7 @@ static const struct v4l2_ioctl_info 
>> v4l2_ioctls[] = {
>>          IOCTL_INFO(VIDIOC_ENUM_FREQ_BANDS, v4l_enum_freq_bands, 
>> v4l_print_freq_band, 0),
>>          IOCTL_INFO(VIDIOC_DBG_G_CHIP_INFO, v4l_dbg_g_chip_info, 
>> v4l_print_dbg_chip_info, INFO_FL_CLEAR(v4l2_dbg_chip_info, match)),
>>          IOCTL_INFO(VIDIOC_QUERY_EXT_CTRL, v4l_query_ext_ctrl, 
>> v4l_print_query_ext_ctrl, INFO_FL_CTRL | 
>> INFO_FL_CLEAR(v4l2_query_ext_ctrl, id)),
>> +       IOCTL_INFO(VIDIOC_DELETE_BUF, v4l_delete_buf, 
>> v4l_print_buffer, INFO_FL_QUEUE),
>>   };
>>   #define V4L2_IOCTLS ARRAY_SIZE(v4l2_ioctls)
>>
>> diff --git a/include/media/v4l2-ioctl.h b/include/media/v4l2-ioctl.h
>> index edb733f21604..2f232ed884c7 100644
>> --- a/include/media/v4l2-ioctl.h
>> +++ b/include/media/v4l2-ioctl.h
>> @@ -163,6 +163,8 @@ struct v4l2_fh;
>>    *     :ref:`VIDIOC_CREATE_BUFS <vidioc_create_bufs>` ioctl
>>    * @vidioc_prepare_buf: pointer to the function that implements
>>    *     :ref:`VIDIOC_PREPARE_BUF <vidioc_prepare_buf>` ioctl
>> + * @vidioc_delete_buf: pointer to the function that implements
>> + *     :ref:`VIDIOC_DELETE_BUF <vidioc_delete_buf>` ioctl
>>    * @vidioc_overlay: pointer to the function that implements
>>    *     :ref:`VIDIOC_OVERLAY <vidioc_overlay>` ioctl
>>    * @vidioc_g_fbuf: pointer to the function that implements
>> @@ -422,6 +424,8 @@ struct v4l2_ioctl_ops {
>>                                    struct v4l2_create_buffers *b);
>>          int (*vidioc_prepare_buf)(struct file *file, void *fh,
>>                                    struct v4l2_buffer *b);
>> +       int (*vidioc_delete_buf)(struct file *file, void *fh,
>> +                                struct v4l2_buffer *b);
>>
>>          int (*vidioc_overlay)(struct file *file, void *fh, unsigned 
>> int i);
>>          int (*vidioc_g_fbuf)(struct file *file, void *fh,
>> diff --git a/include/media/videobuf2-core.h 
>> b/include/media/videobuf2-core.h
>> index 080b783d608d..0f9e68f76b77 100644
>> --- a/include/media/videobuf2-core.h
>> +++ b/include/media/videobuf2-core.h
>> @@ -840,6 +840,15 @@ int vb2_core_create_bufs(struct vb2_queue *q, 
>> enum vb2_memory memory,
>>    */
>>   int vb2_core_prepare_buf(struct vb2_queue *q, unsigned int index, 
>> void *pb);
>>
>> +/**
>> + * vb2_core_delete_buf() -
>> + * @q: pointer to &struct vb2_queue with videobuf2 queue.
>> + * @index:     id number of the buffer.
>> + *
>> + *  Return: returns zero on success; an error code otherwise.
>> + */
>> +int vb2_core_delete_buf(struct vb2_queue *q, unsigned int index);
>> +
>>   /**
>>    * vb2_core_qbuf() - Queue a buffer from userspace
>>    *
>> diff --git a/include/media/videobuf2-v4l2.h 
>> b/include/media/videobuf2-v4l2.h
>> index 88a7a565170e..3beeb4c735f0 100644
>> --- a/include/media/videobuf2-v4l2.h
>> +++ b/include/media/videobuf2-v4l2.h
>> @@ -114,6 +114,17 @@ int vb2_create_bufs(struct vb2_queue *q, struct 
>> v4l2_create_buffers *create);
>>    */
>>   int vb2_prepare_buf(struct vb2_queue *q, struct media_device *mdev,
>>                      struct v4l2_buffer *b);
>> +/**
>> + * vb2_delete_buf() - Delete the buffer from the queue
>> + *
>> + * @q:         pointer to &struct vb2_queue with videobuf2 queue.
>> + * @b:         buffer structure passed from userspace to
>> + *             &v4l2_ioctl_ops->vidioc_delete_buf handler in driver
>> + *
>> + * The return values from this function are intended to be directly 
>> returned
>> + * from &v4l2_ioctl_ops->vidioc_delete_buf handler in driver.
>> + */
>> +int vb2_delete_buf(struct vb2_queue *q, struct v4l2_buffer *b);
>>
>>   /**
>>    * vb2_qbuf() - Queue a buffer from userspace
>> diff --git a/include/uapi/linux/videodev2.h 
>> b/include/uapi/linux/videodev2.h
>> index aee75eb9e686..31bba1915642 100644
>> --- a/include/uapi/linux/videodev2.h
>> +++ b/include/uapi/linux/videodev2.h
>> @@ -2702,6 +2702,8 @@ struct v4l2_create_buffers {
>>   #define VIDIOC_DBG_G_CHIP_INFO  _IOWR('V', 102, struct 
>> v4l2_dbg_chip_info)
>>
>>   #define VIDIOC_QUERY_EXT_CTRL  _IOWR('V', 103, struct 
>> v4l2_query_ext_ctrl)
>> +#define VIDIOC_DELETE_BUF      _IOWR('V', 104, struct v4l2_buffer)
>> +
>>
>>   /* Reminder: when adding new ioctls please add support for them to
>>      drivers/media/v4l2-core/v4l2-compat-ioctl32.c as well! */
>> -- 
>> 2.39.2
>>
