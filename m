Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FF474E3A7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjGKBo1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jul 2023 21:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjGKBo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:44:26 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D151A4;
        Mon, 10 Jul 2023 18:44:24 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 5D45A24DE03;
        Tue, 11 Jul 2023 09:44:16 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 11 Jul
 2023 09:44:16 +0800
Received: from [192.168.60.133] (180.164.60.184) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 11 Jul
 2023 09:44:15 +0800
Message-ID: <560ca37f-74c3-8f36-c118-eb17f92e20b3@starfivetech.com>
Date:   Tue, 11 Jul 2023 09:44:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 7/9] drm/verisilicon: Add drm plane funcs
Content-Language: en-US
To:     Shengyu Qu <wiagn233@outlook.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>
CC:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        <christian.koenig@amd.com>, Bjorn Andersson <andersson@kernel.org>,
        "Heiko Stuebner" <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>, Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Shengyang Chen <shengyang.chen@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>
References: <20230602074043.33872-1-keith.zhao@starfivetech.com>
 <20230602074043.33872-8-keith.zhao@starfivetech.com>
 <TY3P286MB261191B29FB384110094181C9830A@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
From:   Keith Zhao <keith.zhao@starfivetech.com>
In-Reply-To: <TY3P286MB261191B29FB384110094181C9830A@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/11 0:46, Shengyu Qu wrote:
> Hello Keith,
>> +
>> +static void vs_plane_atomic_update(struct drm_plane *plane,
>> +                   struct drm_atomic_state *state)
>> +{
>> +    struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>> +                                       plane);
>> +    unsigned char i, num_planes;
>> +    struct drm_framebuffer *fb;
>> +    struct vs_plane *vs_plane = to_vs_plane(plane);
>> +    //struct drm_plane_state *state = plane->state;
>> +    struct vs_crtc *vs_crtc = to_vs_crtc(new_state->crtc);
>> +    struct vs_plane_state *plane_state = to_vs_plane_state(new_state);
>> +    //struct drm_format_name_buf *name = &plane_state->status.format_name;
>> +
>> +    if (!new_state->fb || !new_state->crtc)
>> +        return;
>> +
>> +    fb = new_state->fb;
>> +
>> +    num_planes = vs_get_plane_number(fb);
>> +
>> +    for (i = 0; i < num_planes; i++) {
>> +        struct vs_gem_object *vs_obj;
>> +
>> +        vs_obj = vs_fb_get_gem_obj(fb, i);
>> +        vs_plane->dma_addr[i] = vs_obj->iova + fb->offsets[i];
> 
> There is a dcache flush operation here in downstream driver. Is that a cache coherence problem?
> 
> Best regards,
> 
> Shengyu
> 
>> +    }
>> +
>> +    plane_state->status.src = drm_plane_state_src(new_state);
>> +    plane_state->status.dest = drm_plane_state_dest(new_state);
>> +
>> +    vs_plane->funcs->update(vs_crtc->dev, vs_plane, plane, state);
>> +}
>>yes , You can find that the current situation is very professional. 
This problem exists at present, but the dma interface is not perfect at now, 
and the dma_sync_single_for_device interface needs to be implemented later. 
I will consider repairing this problem in the form of patch
