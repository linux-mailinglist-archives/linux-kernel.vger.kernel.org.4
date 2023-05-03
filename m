Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BE76F5775
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 13:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjECLyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 07:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjECLyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 07:54:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47AA1BFC
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 04:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683114840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s2SfNb61+SyI1tUDzUUmrbRRGEEy0YuAgISsySgbv14=;
        b=C1MpfwUkRP8sAeWgyf7HTCDbb3xHmft7M8qMTmwfUQfRm3C4kMZtp9BMmhYHSkuvBwbNeu
        ndfOdaSywixVto2sYyd65bjCadLCKtA0QFBAuAmN5kfolnwg/2eFn8s9iyjUAmoOPd+3SH
        Tm+9rID0lElgG7HgXpUbTrwWRXncpJ8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-AOk2fQoVP8eivzJUTGuhIg-1; Wed, 03 May 2023 07:50:11 -0400
X-MC-Unique: AOk2fQoVP8eivzJUTGuhIg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f315735edeso13214775e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 04:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683114611; x=1685706611;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s2SfNb61+SyI1tUDzUUmrbRRGEEy0YuAgISsySgbv14=;
        b=aSDjfY/IDsc17+JrqLO6C5d5x3sd2vAHCjNyIDzD5pD44Vu4+Um6HlqgCzzZz2FfT6
         TIQXx3r5ZnmfIa5KScmZFbooawQP5zwyZ6weF/zhs7mGK/cA5zZs9rS/tQDYDXgxVApg
         A7rK/aNWAzAKlufvnuq/IF02VkB/Xu1SVaH4tyqrxiN3AsSmTzuAS4Aw/0Za5lzh8qGF
         eLoIQ0ErAdzwzTJpmtSbjBjEDzMG8+K0HJ+Erm9uA12XWyvz5XEFoXpIjlvTAt4k0xn9
         WH6dCJx0MFelcv31u1POqobK/NHp3a3sPxcEsIbOtVCYwjiLeFvkdqvyBmpzobhhLSCS
         MdKQ==
X-Gm-Message-State: AC+VfDw+kjqoSZ6uo9L19g7RfqNQvcwY7IvMpuTVzKBmTPXO2S8u+FwH
        UAuoSdqnHhSQzUJB7J9BMAYpjONoYifSQ3YzOb/8078ymuCqTy0K6RxhrU7Mxs3oePV8u0uBYuj
        Y3eXsyDALmAhnsX6A5e3WxYpQ
X-Received: by 2002:a5d:570d:0:b0:2f0:583:44be with SMTP id a13-20020a5d570d000000b002f0058344bemr1387970wrv.0.1683114610857;
        Wed, 03 May 2023 04:50:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7FpQ2jFNfSfXjoMZJtfDYFhpINnGDd/wPmVGl/wJQGxJ4JUCPbQ/yMvNFbV179HybpsluqGA==
X-Received: by 2002:a5d:570d:0:b0:2f0:583:44be with SMTP id a13-20020a5d570d000000b002f0058344bemr1387950wrv.0.1683114610545;
        Wed, 03 May 2023 04:50:10 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id k5-20020adff5c5000000b002f103ca90cdsm33508156wrp.101.2023.05.03.04.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 04:50:09 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Dave Chinner <dchinner@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ye Bin <yebin10@huawei.com>, linux-mm@kvack.org
Subject: Re: [patch 0/3] lib/percpu_counter, cpu/hotplug: Cure the
 cpu_dying_mask woes
In-Reply-To: <20230414162755.281993820@linutronix.de>
References: <20230414162755.281993820@linutronix.de>
Date:   Wed, 03 May 2023 12:50:07 +0100
Message-ID: <xhsmhcz3hk51s.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/23 18:30, Thomas Gleixner wrote:
> Hi!
>
> The cpu_dying_mask is not only undocumented but also to some extent a
> misnomer. It's purpose is to capture the last direction of a cpu_up() or
> cpu_down() operation taking eventual rollback operations into account.
>
> cpu_dying mask is not really useful for general consumption. The
> cpu_dying_mask bits are sticky even after cpu_up() or cpu_down() completes.
>
> A recent fix to plug a race in the per CPU counter code picked
> cpu_dying_mask to cure it. Unfortunately this does not work as the author
> probably expected and the behaviour of cpu_dying_mask is not easy to change
> without breaking the only other and initial user, the scheduler.
>
> This series addresses this by:
>
>    1) Reworking the per CPU counter hotplug mechanism so the race is fully
>       plugged without using cpu_dying_mask
>
>    2) Replacing the cpu_dying_mask logic with hotplug core internal state
>       which is exposed to the scheduler with a properly documented
>       function.
>

For patches 2-3:

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

