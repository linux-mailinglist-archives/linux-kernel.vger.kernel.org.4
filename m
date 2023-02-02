Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377C2687376
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 03:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjBBC6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 21:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBBC6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 21:58:36 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03AC4761D7;
        Wed,  1 Feb 2023 18:58:33 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.133])
        by gateway (Coremail) with SMTP id _____8DxnfDYJttj_QMMAA--.24879S3;
        Thu, 02 Feb 2023 10:58:32 +0800 (CST)
Received: from [10.20.42.133] (unknown [10.20.42.133])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxyubXJttjXPkmAA--.42517S3;
        Thu, 02 Feb 2023 10:58:31 +0800 (CST)
Message-ID: <66c2ec8e-404a-23fa-97ed-644071010300@loongson.cn>
Date:   Thu, 2 Feb 2023 10:58:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 1/3] drm/lsdc: add drm driver for loongson display
 controller
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>,
        Sui Jingfeng <15330273260@189.cn>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Randy Dunlap <rdunlap@infradead.org>
References: <20220203082546.3099-1-15330273260@189.cn>
 <20220203082546.3099-2-15330273260@189.cn>
 <20220203085851.yqstkfgt4dz7rcnw@houat>
 <4dd6d32a-9818-1adf-cb3f-20c183ae2020@189.cn>
 <20220209083633.mlfbiydi7cbpgexa@houat>
From:   suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <20220209083633.mlfbiydi7cbpgexa@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxyubXJttjXPkmAA--.42517S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxXF1DuF17CF17tr4ktr1kXwb_yoWruFW3pr
        Z0yF98Ka1qqry8Xryqqw4DtFsa9rs5Kry2qry5Jr12kF15Kr1fCr18GrZrCa1kJrWDGw1Y
        v3W5CF98Ka1Y9aDanT9S1TB71UUUU17qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1q6r43M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jTq2NUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/2/9 16:36, Maxime Ripard wrote:
> On Fri, Feb 04, 2022 at 12:41:37AM +0800, Sui Jingfeng wrote:
>>>> +static int lsdc_primary_plane_atomic_check(struct drm_plane *plane,
>>>> +					   struct drm_atomic_state *state)
>>>> +{
>>>> +	struct drm_device *ddev = plane->dev;
>>>> +	struct lsdc_device *ldev = to_lsdc(ddev);
>>>> +	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
>>>> +	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
>>>> +	struct drm_framebuffer *new_fb = new_plane_state->fb;
>>>> +	struct drm_framebuffer *old_fb = old_plane_state->fb;
>>>> +	struct drm_crtc *crtc = new_plane_state->crtc;
>>>> +	u32 new_format = new_fb->format->format;
>>>> +	struct drm_crtc_state *new_crtc_state;
>>>> +	struct lsdc_crtc_state *priv_crtc_state;
>>>> +	int ret;
>>>> +
>>>> +	if (!crtc)
>>>> +		return 0;
>>>> +
>>>> +	new_crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
>>>> +	if (WARN_ON(!new_crtc_state))
>>>> +		return -EINVAL;
>>>> +
>>>> +	priv_crtc_state = to_lsdc_crtc_state(new_crtc_state);
>>>> +
>>>> +	ret = drm_atomic_helper_check_plane_state(new_plane_state,
>>>> +						  new_crtc_state,
>>>> +						  DRM_PLANE_HELPER_NO_SCALING,
>>>> +						  DRM_PLANE_HELPER_NO_SCALING,
>>>> +						  false,
>>>> +						  true);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	/*
>>>> +	 * Require full modeset if enabling or disabling a plane,
>>>> +	 * or changing its position, size, depth or format.
>>>> +	 */
>>>> +	if ((!new_fb || !old_fb ||
>>>> +	     old_plane_state->crtc_x != new_plane_state->crtc_x ||
>>>> +	     old_plane_state->crtc_y != new_plane_state->crtc_y ||
>>>> +	     old_plane_state->crtc_w != new_plane_state->crtc_w ||
>>>> +	     old_plane_state->crtc_h != new_plane_state->crtc_h ||
>>>> +	     old_fb->format->format != new_format))
>>>> +		new_crtc_state->mode_changed = true;
>>>> +
>>>> +
>>>> +	priv_crtc_state->pix_fmt = lsdc_primary_get_default_format(crtc);
>>> Storing the pixel format in the CRTC state is weird? What would happen
>>> if you have a primary plane and a cursor in different formats?
>>>
>>> Also, reading the default format from a register doesn't look right.
>>> atomic_check can occur at any time, including before a previous commit,
>>> or while the hardware is disabled. You should rely on either a constant
>>> or the previous state here.
>>>
>> Currently, private CRTC state(priv_crtc_state) is not get used by the cursor's
>> atomic_check() and atomic_update(). I means this is only for the primary plane.
>> And both and the primary and the cursor using  XRGB8888 format, what I really
>> want here is let the atomic_update to update the framebuffer's format, because
>> the firmware (pmon) of some board set the framebuffer's format as RGB565.
> atomic_update will be called each time the plane state is changed, so it
> won't be an issue: when the first state will be committed, your
> atomic_update function will be called and thus you'll overwrite what was
> left of the firmware setup.

I am agree with you that  the format is a property of the plane, the 
code using wrong abstraction.

this is because i am confused by our DC hardware at that time. 
atomic_update is failed to update

the FB format because our CRTC hardware has bug. It can only success 
update fb format with CRTC

reset bit set in drm_crtc_funcs.reset(). Otherwise the CRTC still using 
RGB565 format to parse the

RGBX8888 frame buffer.  We finally found the hardware bug via debugfs, 
just dump the register value.

we found that the fb format didn't get update. The hardware bug leading 
us using the wrong abstraction.

we do not understand the DRM core fully at that time. We have revised 
our patch, thank you point out that.

>> If the hardware's format is same with the plane state, then there is no need to
>> update the FB's format register, save a function call, right?
> My point was more about the fact that you're using the wrong abstraction
> there. The format is a property of the plane, not from the CRTC. In KMS
> (and in most drivers), you can have multiple planes with different
> formats all attached to the same CRTC just fine.
>
> Maxime

Our CRTC have cursor plane and primary plane, composite is doing by the 
CRTC hardware automatically.

there no depth property, the cursor is always on the top of the CRTC.  
If the CRTC format is not same format

I think we should convert the format of cursor to the format of primary 
plane at atomic_update, by introduce

a shadow plane. Thanks for your guiding.

