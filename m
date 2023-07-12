Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CBF750509
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjGLKqd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Jul 2023 06:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjGLKqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:46:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3BA12F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:46:29 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1qJXMU-0004Hy-Ge; Wed, 12 Jul 2023 12:46:22 +0200
Message-ID: <1a3f07cb473c520dcd23c4d214f3503441cd7a71.camel@pengutronix.de>
Subject: Re: [PATCH 3/6] drm/amdgpu: Rework coredump to use memory
 dynamically
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     pierre-eric.pelloux-prayer@amd.com,
        'Marek =?UTF-8?Q?Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
        michel.daenzer@mailbox.org,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        kernel-dev@igalia.com, alexander.deucher@amd.com
Date:   Wed, 12 Jul 2023 12:46:20 +0200
In-Reply-To: <3764d627-d632-5754-0bcc-a150c157d9f9@amd.com>
References: <20230711213501.526237-1-andrealmeid@igalia.com>
         <20230711213501.526237-4-andrealmeid@igalia.com>
         <e488da74-af52-62eb-d601-0e8a13cf0e87@amd.com>
         <0e7f2b0cc29ac77d4a55d0de6a66c477d867fbf7.camel@pengutronix.de>
         <3764d627-d632-5754-0bcc-a150c157d9f9@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, dem 12.07.2023 um 12:39 +0200 schrieb Christian König:
> Am 12.07.23 um 10:59 schrieb Lucas Stach:
> > Am Mittwoch, dem 12.07.2023 um 10:37 +0200 schrieb Christian König:
> > > Am 11.07.23 um 23:34 schrieb André Almeida:
> > > > Instead of storing coredump information inside amdgpu_device struct,
> > > > move if to a proper separated struct and allocate it dynamically. This
> > > > will make it easier to further expand the logged information.
> > > Verry big NAK to this. The problem is that memory allocation isn't
> > > allowed during a GPU reset.
> > > 
> > > What you could do is to allocate the memory with GFP_ATOMIC or similar,
> > > but for a large structure that might not be possible.
> > > 
> > I'm still not fully clear on what the rules are here. In etnaviv we do
> > devcoredump allocation in the GPU reset path with __GFP_NOWARN |
> > __GFP_NORETRY, which means the allocation will kick memory reclaim if
> > necessary, but will just give up if no memory could be made available
> > easily. This satisfies the forward progress guarantee in the absence of
> > successful memory allocation, which is the most important property in
> > this path, I think.
> > 
> > However, I'm not sure if the reclaim could lead to locking issues or
> > something like that with the more complex use-cases with MMU notifiers
> > and stuff like that. Christian, do you have any experience or
> > information that would be good to share in this regard?
> 
> Yeah, very good question.
> 
> __GFP_NORETRY isn't sufficient as far as I know. Reclaim must be 
> completely suppressed to be able to allocate in a GPU reset handler.
> 
> Daniel added lockdep annotation to some of the dma-fence signaling paths 
> and this yielded quite a bunch of potential deadlocks.
> 
> It's not even that reclaim itself waits for dma_fences (that can happen, 
> but is quite unlikely), but rather that reclaim needs locks and under 
> those locks we then wait for dma_fences.
> 
> We should probably add a define somewhere which documents that 
> (GFP_ATOMIC | __NO_WARN) should be used in the GPU reset handlers when 
> allocating memory for coredumps.
> 
> Regards,
> Christian.
> 
> > 
> > Regards,
> > Lucas
> > 
> > > Regards,
> > > Christian.
> > > 
> > > > Signed-off-by: André Almeida <andrealmeid@igalia.com>
> > > > ---
> > > >    drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 14 +++--
> > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 65 ++++++++++++++--------
> > > >    2 files changed, 51 insertions(+), 28 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > > index dbe062a087c5..e1cc83a89d46 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > > @@ -1068,11 +1068,6 @@ struct amdgpu_device {
> > > >    	uint32_t                        *reset_dump_reg_list;
> > > >    	uint32_t			*reset_dump_reg_value;
> > > >    	int                             num_regs;
> > > > -#ifdef CONFIG_DEV_COREDUMP
> > > > -	struct amdgpu_task_info         reset_task_info;
> > > > -	bool                            reset_vram_lost;
> > > > -	struct timespec64               reset_time;
> > > > -#endif
> > > >    
> > > >    	bool                            scpm_enabled;
> > > >    	uint32_t                        scpm_status;
> > > > @@ -1085,6 +1080,15 @@ struct amdgpu_device {
> > > >    	uint32_t			aid_mask;
> > > >    };
> > > >    
> > > > +#ifdef CONFIG_DEV_COREDUMP
> > > > +struct amdgpu_coredump_info {
> > > > +	struct amdgpu_device		*adev;
> > > > +	struct amdgpu_task_info         reset_task_info;
> > > > +	struct timespec64               reset_time;
> > > > +	bool                            reset_vram_lost;
> > > > +};
> > > > +#endif
> > > > +
> > > >    static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> > > >    {
> > > >    	return container_of(ddev, struct amdgpu_device, ddev);
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > index e25f085ee886..23b9784e9787 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > @@ -4963,12 +4963,17 @@ static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
> > > >    	return 0;
> > > >    }
> > > >    
> > > > -#ifdef CONFIG_DEV_COREDUMP
> > > > +#ifndef CONFIG_DEV_COREDUMP
> > > > +static void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
> > > > +			    struct amdgpu_reset_context *reset_context)
> > > > +{
> > > > +}
> > > > +#else
> > > >    static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,
> > > >    		size_t count, void *data, size_t datalen)
> > > >    {
> > > >    	struct drm_printer p;
> > > > -	struct amdgpu_device *adev = data;
> > > > +	struct amdgpu_coredump_info *coredump = data;
> > > >    	struct drm_print_iterator iter;
> > > >    	int i;
> > > >    
> > > > @@ -4982,21 +4987,21 @@ static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,
> > > >    	drm_printf(&p, "**** AMDGPU Device Coredump ****\n");
> > > >    	drm_printf(&p, "kernel: " UTS_RELEASE "\n");
> > > >    	drm_printf(&p, "module: " KBUILD_MODNAME "\n");
> > > > -	drm_printf(&p, "time: %lld.%09ld\n", adev->reset_time.tv_sec, adev->reset_time.tv_nsec);
> > > > -	if (adev->reset_task_info.pid)
> > > > +	drm_printf(&p, "time: %lld.%09ld\n", coredump->reset_time.tv_sec, coredump->reset_time.tv_nsec);
> > > > +	if (coredump->reset_task_info.pid)
> > > >    		drm_printf(&p, "process_name: %s PID: %d\n",
> > > > -			   adev->reset_task_info.process_name,
> > > > -			   adev->reset_task_info.pid);
> > > > +			   coredump->reset_task_info.process_name,
> > > > +			   coredump->reset_task_info.pid);
> > > >    
> > > > -	if (adev->reset_vram_lost)
> > > > +	if (coredump->reset_vram_lost)
> > > >    		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
> > > > -	if (adev->num_regs) {
> > > > +	if (coredump->adev->num_regs) {
> > > >    		drm_printf(&p, "AMDGPU register dumps:\nOffset:     Value:\n");
> > > >    
> > > > -		for (i = 0; i < adev->num_regs; i++)
> > > > +		for (i = 0; i < coredump->adev->num_regs; i++)
> > > >    			drm_printf(&p, "0x%08x: 0x%08x\n",
> > > > -				   adev->reset_dump_reg_list[i],
> > > > -				   adev->reset_dump_reg_value[i]);
> > > > +				   coredump->adev->reset_dump_reg_list[i],
> > > > +				   coredump->adev->reset_dump_reg_value[i]);
> > > >    	}
> > > >    
> > > >    	return count - iter.remain;
> > > > @@ -5004,14 +5009,34 @@ static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,
> > > >    
> > > >    static void amdgpu_devcoredump_free(void *data)
> > > >    {
> > > > +	kfree(data);
> > > >    }
> > > >    
> > > > -static void amdgpu_reset_capture_coredumpm(struct amdgpu_device *adev)
> > > > +static void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
> > > > +			    struct amdgpu_reset_context *reset_context)
> > > >    {
> > > > +	struct amdgpu_coredump_info *coredump;
> > > >    	struct drm_device *dev = adev_to_drm(adev);
> > > >    
> > > > -	ktime_get_ts64(&adev->reset_time);
> > > > -	dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_KERNEL,
> > > > +	coredump = kmalloc(sizeof(*coredump), GFP_KERNEL);
> > > > +
> > > > +	if (!coredump) {
> > > > +		DRM_ERROR("%s: failed to allocate memory for coredump\n", __func__);
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	memset(coredump, 0, sizeof(*coredump));
> > > > +
> > > > +	coredump->reset_vram_lost = vram_lost;
> > > > +
> > > > +	if (reset_context->job && reset_context->job->vm)
> > > > +		coredump->reset_task_info = reset_context->job->vm->task_info;
> > > > +
> > > > +	coredump->adev = adev;
> > > > +
> > > > +	ktime_get_ts64(&coredump->reset_time);
> > > > +
> > > > +	dev_coredumpm(dev->dev, THIS_MODULE, coredump, 0, GFP_KERNEL,
> > > >    		      amdgpu_devcoredump_read, amdgpu_devcoredump_free);
> > > >    }
> > > >    #endif
> > > > @@ -5119,15 +5144,9 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
> > > >    					goto out;
> > > >    
> > > >    				vram_lost = amdgpu_device_check_vram_lost(tmp_adev);
> > > > -#ifdef CONFIG_DEV_COREDUMP
> > > > -				tmp_adev->reset_vram_lost = vram_lost;
> > > > -				memset(&tmp_adev->reset_task_info, 0,
> > > > -						sizeof(tmp_adev->reset_task_info));
> > > > -				if (reset_context->job && reset_context->job->vm)
> > > > -					tmp_adev->reset_task_info =
> > > > -						reset_context->job->vm->task_info;
> > > > -				amdgpu_reset_capture_coredumpm(tmp_adev);
> > > > -#endif
> > > > +
> > > > +				amdgpu_coredump(tmp_adev, vram_lost, reset_context);
> > > > +
> > > >    				if (vram_lost) {
> > > >    					DRM_INFO("VRAM is lost due to GPU reset!\n");
> > > >    					amdgpu_inc_vram_lost(tmp_adev);
> 

