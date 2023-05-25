Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454627117A7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241857AbjEYTvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 15:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240643AbjEYTux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 15:50:53 -0400
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com [IPv6:2607:f8b0:4864:20::d4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BFE9B
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 12:50:51 -0700 (PDT)
Received: by mail-io1-xd4a.google.com with SMTP id ca18e2360f4ac-769036b47a7so5723839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 12:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685044250; x=1687636250;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ObkkrpGCZ6jiKurOn4Vm2QFLFy19smc7EknbNsel8tg=;
        b=Pj+sKz35OjCQOOnQcFAi6dtpsCjwDKDmMVaXg0a3z1YeW+CvzL0AVuyFzwV2rnINyi
         ixzpzsEGdB+yX9HKMdnkhHqlbwuMpyDc2erzo2hMQu1gmlMV3ekQJm5HMfsdvt8zl6Km
         HowIPDRB+mHeR28XVZLfWMTN/gW7/qmqxNAIBK+SVagF8ktnt/XIFkY4bT+WmNQFN0o5
         gWMArh+mvjuAbJsGjogu5zpScdE2RnIocsmemz5b1DTsjKvW9V+PejTp1+g7mxKorWxy
         uF/NxF6/CA6ppJX4vzcrqjQxUxzrrnKfXRdY9VB1TnmXJF9ZYiQNDIkkMf1ByTpMHxyS
         1T5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685044251; x=1687636251;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ObkkrpGCZ6jiKurOn4Vm2QFLFy19smc7EknbNsel8tg=;
        b=XzYUvna0nl52OFvczuTmSK6C6q5Lg/c4JNU2s8mWjKa0mRB7QA1sITmjzC03lKovaW
         J2OzFH0x2gZfQIHYmFYN18jTDu3undwB+r8LcXEezUhzOqkLcDmav3Wh0anWhhdvgPyr
         ecGeYE2Yztqnd8B/NUTQP3Ftoz7OEhqKTXc+siOq99MWCm0P69Vk3kLYkGr2ERajvuxw
         vYxVsnT4jMzqXctXuVvxS9sVvIhRK/lCKpGa5HpU+QaDIMfzsziyCHUKrF9ZSEZcefqi
         tM1CtTH/30weNWEXDP5A6C7YUdWYL2MnWl3tWWiP6vBY3ZaJOO9brWPr/jRBWgsBHrdt
         CN7g==
X-Gm-Message-State: AC+VfDwWXDzI/e/Dyu6E/gtUBOrfg4hWRw9hV0+MDF7zQ1LiKwJ88ur2
        oQpe7i+afpYuM8zAMgUJ1VR6pUFiBLpQ31vg5A==
X-Google-Smtp-Source: ACHHUZ6Z9KtoHJcC7GMhgxz3P8RqY3VCZI0iGscR2klaQUEZZ+6Qywdmzo991lbX54ZFbRF0UxjhEzYCVxqPJ/+YQA==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a02:29c7:0:b0:41b:b95:89db with SMTP
 id p190-20020a0229c7000000b0041b0b9589dbmr5348368jap.5.1685044250766; Thu, 25
 May 2023 12:50:50 -0700 (PDT)
Date:   Thu, 25 May 2023 19:50:49 +0000
In-Reply-To: <20230509142235.3284028-8-kristina.martsenko@arm.com>
Mime-Version: 1.0
Message-ID: <gsnta5xsb36u.fsf@coltonlewis-kvm.c.googlers.com>
Subject: RE: [PATCH v2 07/11] arm64: mops: handle MOPS exceptions
From:   Colton Lewis <coltonlewis@google.com>
To:     Kristina Martsenko <kristina.martsenko@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Luis Machado <luis.machado@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if (esr & ESR_ELx_MOPS_ISS_MEM_INST) {
> +		/* SET* instruction */
> +		if (option_a ^ wrong_option) {
> +			/* Format is from Option A; forward set */
> +			pt_regs_write_reg(regs, dstreg, dst + size);
> +			pt_regs_write_reg(regs, sizereg, -size);
> +		}
> +	} else {
> +		/* CPY* instruction */
> +		if (!(option_a ^ wrong_option)) {
> +			/* Format is from Option B */
> +			if (regs->pstate & PSR_N_BIT) {
> +				/* Backward copy */
> +				pt_regs_write_reg(regs, dstreg, dst - size);
> +				pt_regs_write_reg(regs, srcreg, src - size);
> +			}
> +		} else {
> +			/* Format is from Option A */
> +			if (size & BIT(63)) {
> +				/* Forward copy */
> +				pt_regs_write_reg(regs, dstreg, dst + size);
> +				pt_regs_write_reg(regs, srcreg, src + size);
> +				pt_regs_write_reg(regs, sizereg, -size);
> +			}
> +		}
> +	}

I can see an argument for styling things closely to the ARM manual as
you have done here, but Linux style recommends against deep nesting. In
this case it is unneeded. I believe this can be written as a single
if-else chain and that makes it easier to distinguish the three options.

if ((esr & ESR_ELx_MOPS_ISS_MEM_INST) && (option_a ^ wrong_option)) {
	/* Format is from Option A; forward set */
	pt_regs_write_reg(regs, dstreg, dst + size);
	pt_regs_write_reg(regs, sizereg, -size);
} else if ((option_a ^ wrong_option) && (size & BIT(63)) {
	/* Forward copy */
	pt_regs_write_reg(regs, dstreg, dst + size);
	pt_regs_write_reg(regs, srcreg, src + size);
	pt_regs_write_reg(regs, sizereg, -size);
} else if (regs-pstate & PSR_N_BIT) {
	/* Backward copy */
	pt_regs_write_reg(regs, dstreg, dst - size);
	pt_regs_write_reg(regs, srcreg, src - size);
}
