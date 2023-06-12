Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4CF72C2D1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237038AbjFLLcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbjFLLcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:32:36 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7865835A9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:08:09 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f619c2ba18so4621996e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1686568086; x=1689160086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cqc/dWIkGp13SLIIu6IJWBJIUBo6SVnCPSxnZiD/2qs=;
        b=Ee1kxW2zIBpufE5Pd30SjljWSF8bmQ23PvcXOTfBLWDuhuzmi4GNxm81r6THqfr1R8
         TF/XbV/vQPE7NAjqG5CUcG091GIVP+OIZkR2eVbcnqSSGulqYKQ0tS4fGce1Vqz72BEK
         4dnF5FIjP/ixuv50EXQjUSlglRcu6SFfk78g0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686568086; x=1689160086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cqc/dWIkGp13SLIIu6IJWBJIUBo6SVnCPSxnZiD/2qs=;
        b=LYjCab3/xPqawgzHgjTNZxbqzvj9HwYgcNw1BD5sZIpztmmMgrnE49w32kHWJ5pQ6K
         nFszRzwHVC+ubnFHHpcNWQFt1dL3AZAvlkIhqpMbTcrT37/Lc8758uNXSLNeJv3GVWTB
         SODSVbfh5W/LFAJc3EBJWWB723oxgORv6BsmCW5IgEE15ZgqMeW7X0puHcAgAPpJEGPZ
         Mnb2vGyG25X/8EmbFaVhSwo4D5g/9V5QpEbgNIOvC7x+6xI+jAJnCxoppgq6B+ZuGJgu
         H28dAPXZflpaaripek1dr1WuNf6g9yLAcnlxCjmt7AzKZKMjMD85rx+MdRHXxSPGAhYV
         hH2w==
X-Gm-Message-State: AC+VfDxVyJsPmuoqR0jK+vWVPRm1xn1V/OVNZiz/z9ndGmY7xfCiTihz
        3VbnkdHCZ/iRW89PmeaGTmP82g==
X-Google-Smtp-Source: ACHHUZ7b8SUOyAvo5mZ/ej3K8XSkF1lyVZaH5wXsQAhZBy44s+7p1e2LN2fuBFmbbRRFjOsD8ITAwQ==
X-Received: by 2002:a05:6512:3123:b0:4f3:a723:1dc6 with SMTP id p3-20020a056512312300b004f3a7231dc6mr3958647lfd.52.1686568086176;
        Mon, 12 Jun 2023 04:08:06 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id q5-20020a19a405000000b004edafe3f8dbsm1420627lfc.11.2023.06.12.04.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 04:08:05 -0700 (PDT)
Message-ID: <546e2ab5-f520-c85e-d6f4-ca7b02457d4c@rasmusvillemoes.dk>
Date:   Mon, 12 Jun 2023 13:08:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/4] vsscanf(): do not skip spaces
Content-Language: en-US, da
To:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Lee Jones <lee@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        Christoph Hellwig <hch@lst.de>
References: <20230610204044.3653-1-demi@invisiblethingslab.com>
 <20230610204044.3653-4-demi@invisiblethingslab.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20230610204044.3653-4-demi@invisiblethingslab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2023 22.40, Demi Marie Obenour wrote:
> Passing spaces before e.g. an integer is usually
> not intended. 

Maybe, maybe not. But it's mandated by POSIX/C99.

And of course we are free to ignore that and implement our own semantics
(though within the constraints that we really want -Wformat to help us),
but there seems to be existing code in-tree that relies on this
behavior. For example I think this will break
fsl_sata_intr_coalescing_store() which uses a scanf format of "%u%u".

Sure, that could just say "%u %u" instead, but the point is that
currently it doesn't. So without some reasonably thorough analysis
across the tree, and updates of affected callers, NAK.

Rasmus

