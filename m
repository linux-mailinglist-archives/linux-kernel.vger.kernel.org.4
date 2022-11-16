Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F9B62C5EB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbiKPRHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbiKPRHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:07:11 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3D258024
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:06:50 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id k2so45686261ejr.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ntvWgXmyJ+ykqZ+C7I8wJwNPUjVuwRNNvjO3LgHYeZQ=;
        b=ijm23BXVpC91ubga8PZXme39BcIbxyQVTExxRKXLSvZDwSo1X0uMeKsr7Af4VNMN5F
         3NheMhsqE43RygVDM/jqGXonihzTc9MNVlqK3YiBbqPGVwkBhqeJxKrh3IDLPdbivdbI
         5UF69y2Xsi16bX6JXRDlIbeGzG+NFKuoa1rTjK5uI3yc98PJ8r/C7knt4fsZiZaPbBEu
         C+nUdfI+n3I89DEqDmtzg89PBhJJuF2Dzei+N7FTHK2b76i7PNqem+0Dv9w4cD2XuUjs
         tPnFZNspYuymVCs3upZV9M8kNEsHnbByVfWFQGI1a07rLlebliWtUZeAmqqUJl7ny9QT
         lKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntvWgXmyJ+ykqZ+C7I8wJwNPUjVuwRNNvjO3LgHYeZQ=;
        b=M1KbD+cJoawtZ76tFMiNbkBbl1PNZraFLeanpG8YQSwTsGIXdV4fDPHtzcVY2LHd0l
         PmJi09f7LPoFxrMwsOMzaBch9JWUoFwJzznC0UJRYvid7CtxuegB2jAcWiIuVIww7Ht/
         7tjVkotonFC6XwtD2v+JuFIL3tfNPKbta+qL7DZERFoIhkmLPZ9yPMhaPo6xsTAvk86i
         Q0mgCRbewKCmVGZpS2fhMsdTnD2Dw92dExnGXVT7cGb78D/GlXOHDvonKuNHQIfVOe6p
         HFwvk5Rfb95TjcNqqiXSnuI7rWpQvUDe6Gp4g0kt7XxCQvJW3Vk0DRi/YAw0N4RYLcsA
         1eHg==
X-Gm-Message-State: ANoB5pkjlOC4LG5fCMSmHFrHvm72tQpvecl5MoynHVWz1ywstWhWX87F
        iy9ZKELd3ixabhWjB8fqSUv0pg==
X-Google-Smtp-Source: AA0mqf7OUgDhaAkgf87o1aEoAM3GV5pr2cWK1jkNVYywr1xdXN9du8Ug6c89/kiZd1oJFyyfqrOXQw==
X-Received: by 2002:a17:906:a2d4:b0:7ac:db70:2f90 with SMTP id by20-20020a170906a2d400b007acdb702f90mr18116893ejb.297.1668618409178;
        Wed, 16 Nov 2022 09:06:49 -0800 (PST)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id r18-20020a1709061bb200b0077d37a5d401sm7115248ejg.33.2022.11.16.09.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 09:06:48 -0800 (PST)
Date:   Wed, 16 Nov 2022 17:06:44 +0000
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andrew Walbran <qwandor@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 12/12] ANDROID: KVM: arm64: pkvm: Add support for
 fragmented FF-A descriptors
Message-ID: <Y3UYpGBlU1W62Mfz@google.com>
References: <20221116170335.2341003-1-qperret@google.com>
 <20221116170335.2341003-13-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116170335.2341003-13-qperret@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 Nov 2022 at 17:03:35 (+0000), Quentin Perret wrote:
> FF-A memory descriptors may need to be sent in fragments when they don't
> fit in the mailboxes. Doing so involves using the FRAG_TX and FRAG_RX
> primitives defined in the FF-A protocol.
> 
> Add support in the pKVM FF-A relayer for fragmented descriptors by
> monitoring outgoing FRAG_TX transactions and by buffering large
> descriptors on the reclaim path.

And it seems that I have forgotten to remove the ANDROID: tag from this
patch prior to posting ... Please ignore, it'll be gone in v2.

Cheers,
Quentin
