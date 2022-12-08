Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E8A6466D3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 03:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiLHCP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 21:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiLHCPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 21:15:55 -0500
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87084E84
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 18:15:54 -0800 (PST)
Received: from localhost.localdomain (unknown [124.16.138.125])
        by APP-01 (Coremail) with SMTP id qwCowADXWOzWSJFjkd+mBQ--.34315S2;
        Thu, 08 Dec 2022 10:15:50 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     robin.murphy@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        airlied@gmail.com, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] drm: mali-dp: Add check for kzalloc
Date:   Thu,  8 Dec 2022 10:15:49 +0800
Message-Id: <20221208021549.26704-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADXWOzWSJFjkd+mBQ--.34315S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Xry3tFWDAr1Uur1kJw4kCrg_yoW8JrW3pr
        47KFnakFZ8ZrnxGwn7ZF1UuFn0yrW3KFyrCr95Jwn5ur15uF93AFs7try3WF47CrZ3tw1Y
        va12qFZ8ZF1qy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_
        Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF3kuDUUUU
X-Originating-IP: [124.16.138.125]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 09:59:04PM +0800, Robin Murphy wrote:
>> As kzalloc may fail and return NULL pointer, it should be better to check
>> the return value in order to avoid the NULL pointer dereference in
>> __drm_atomic_helper_connector_reset.
> 
> This commit message is nonsense; if 
> __drm_atomic_helper_connector_reset() would dereference the NULL implied 
> by &mw_state->base, it would equally still dereference the explicit NULL 
> pointer passed after this patch.
> 
> The current code works out OK because "base" is the first member of 
> struct malidp_mw_connector_state, thus if mw_state is NULL then 
> &mw_state->base == NULL + 0 == NULL. Now you *could* argue that this 
> isn't robust if the layout of struct malidp_mw_connector_state ever 
> changes, and that could be a valid justification for making this change, 
> but the reason given certainly isn't.
> 
> Arithmetic on a (potentially) NULL pointer may well be a sign that it's 
> worth a closer look to check whether it really is what the code intended 
> to do, but don't automatically assume it has to be a bug. Otherwise, 
> good luck with "fixing" every user of container_of() throughout the 
> entire kernel.

I have sent a new patch with the modified commit mesage.

Thanks,
Jiang

