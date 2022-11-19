Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62409630EF0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 14:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiKSNRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 08:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKSNRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 08:17:10 -0500
Received: from cstnet.cn (smtp23.cstnet.cn [159.226.251.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D61A8B12A
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 05:17:05 -0800 (PST)
Received: from localhost.localdomain (unknown [124.16.138.125])
        by APP-03 (Coremail) with SMTP id rQCowACXn5dD13hjEbIYAA--.22946S2;
        Sat, 19 Nov 2022 21:16:51 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     contact@emersion.fr
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, nicholas.kazlauskas@amd.com, roman.li@amd.com,
        aurabindo.pillai@amd.com, Jerry.Zuo@amd.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] drm/amd/display: rewrite the check for mods
Date:   Sat, 19 Nov 2022 21:16:50 +0800
Message-Id: <20221119131650.21525-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACXn5dD13hjEbIYAA--.22946S2
X-Coremail-Antispam: 1UD129KBjvdXoWrur1fCrW7JF1UZrykKFWxJFb_yoWkKwb_WF
        1kC3WDuw1DuF1Fvrs5G343CwsIyF4kJr1IgFs3tw4Dtwn8WrZ5Xr92v3s3Ga1xur4ftrsr
        GF1qv343Xw1DujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbV8FF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
        n2IY04v7MxkIecxEwVAFwVW5GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JU3uc_UUUUU=
X-Originating-IP: [124.16.138.125]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022 15:56:09 +0800, Simon Ser wrote:
>> @@ -638,11 +638,14 @@ static int get_plane_modifiers(struct amdgpu_device *adev, unsigned int plane_ty
>>  		return 0;
>>  
>>  	*mods = kmalloc(capacity * sizeof(uint64_t), GFP_KERNEL);
>> +	if (!*mods)
>> +		return -ENOMEM;
>> +
>>  
>>  	if (plane_type == DRM_PLANE_TYPE_CURSOR) {
>>  		add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_LINEAR);
>>  		add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_INVALID);
>> -		return *mods ? 0 : -ENOMEM;
>> +		return 0;
>>  	}
>>  
>>  	switch (adev->family) {
>> @@ -671,9 +674,6 @@ static int get_plane_modifiers(struct amdgpu_device *adev, unsigned int plane_ty
>>  	/* INVALID marks the end of the list. */
>>  	add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_INVALID);
>>  
>> -	if (!*mods)
>> -		return -ENOMEM;
>> -
>>  	return 0;
>>  }
 
> This breaks the "size" out-parameter.

No, it will not change the value of the "size".
The "size" can only be modified by add_modifier().
However, when the "*mods" is NULL, add_modifier() will return immediately,
without the execution of "*size += 1;".
Therefore, when the "*mods" is NULL, the rest of the function is useless,
which should be better to skip.

Jiang

