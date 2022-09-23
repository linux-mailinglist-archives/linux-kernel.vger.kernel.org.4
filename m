Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453845E7483
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiIWHEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiIWHEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:04:07 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0511911ED4D;
        Fri, 23 Sep 2022 00:04:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MYjmv3XxYz4x3w;
        Fri, 23 Sep 2022 17:03:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1663916640;
        bh=1iXxSu50WtbEc6IZd3//2X2o8ST6IxoIkqMeTSYP8WY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TnT637an4yLiiy8/YYhlUVAXWl0vaSFXC4tDJF6Rty/P1MLmQR6xbgT72sJFlbfRL
         RF5RJ8c2WR7Ae2BtCeTL8DgPfaFWG0Swuw5ceQn3V4Rgc1uxzh875Qm4jtoKsEF0Gy
         eDU9bd6SZ4Si+hveVGsYo3RJngifYZnCJ3qrnptyxKRcHIY6TyIOk11UW7oCFIXJwW
         2zDfGhFW/HXO16o/4GlTGDqrlhQ0N0Wgf8+SnCZF2GHPDwGahrnym4EgixY1wAOzYp
         WVZwA5af2O0LekH6IflX4pCEMH5vdyTTw3w/3zIJMiGYt/xCOfIJNpLqqtBknJkYeA
         Wka1ga3IEMMhQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Paul Moore <paul@paul-moore.com>,
        Nathan Lynch <nathanl@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org, serge@hallyn.com,
        ajd@linux.ibm.com, gcwilson@linux.ibm.com, nayna@linux.ibm.com
Subject: Re: [PATCH 1/2] powerpc/pseries: block untrusted device tree
 changes when locked down
In-Reply-To: <CAHC9VhQG_jEh_H8pV-qJgX2oX_fyGjXoBV7_EJOgvOd4ndc+Xw@mail.gmail.com>
References: <20220922193817.106041-1-nathanl@linux.ibm.com>
 <20220922193817.106041-2-nathanl@linux.ibm.com>
 <CAHC9VhQG_jEh_H8pV-qJgX2oX_fyGjXoBV7_EJOgvOd4ndc+Xw@mail.gmail.com>
Date:   Fri, 23 Sep 2022 17:03:59 +1000
Message-ID: <87zgeqzi5c.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Moore <paul@paul-moore.com> writes:
> On Thu, Sep 22, 2022 at 3:38 PM Nathan Lynch <nathanl@linux.ibm.com> wrote:
>>
>> The /proc/powerpc/ofdt interface allows the root user to freely alter
>> the in-kernel device tree, enabling arbitrary physical address writes
>> via drivers that could bind to malicious device nodes, thus making it
>> possible to disable lockdown.
>>
>> Historically this interface has been used on the pseries platform to
>> facilitate the runtime addition and removal of processor, memory, and
>> device resources (aka Dynamic Logical Partitioning or DLPAR). Years
>> ago, the processor and memory use cases were migrated to designs that
>> happen to be lockdown-friendly: device tree updates are communicated
>> directly to the kernel from firmware without passing through untrusted
>> user space. I/O device DLPAR via the "drmgr" command in powerpc-utils
>> remains the sole legitimate user of /proc/powerpc/ofdt, but it is
>> already broken in lockdown since it uses /dev/mem to allocate argument
>> buffers for the rtas syscall. So only illegitimate uses of the
>> interface should see a behavior change when running on a locked down
>> kernel.
>>
>> Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
>> ---
>>  arch/powerpc/platforms/pseries/reconfig.c | 5 +++++
>>  include/linux/security.h                  | 1 +
>>  security/security.c                       | 1 +
>>  3 files changed, 7 insertions(+)
>
> A couple of small nits below, but in general this seems reasonable.
> However, as we are currently at -rc6 I would like us to wait to merge
> this until after the upcoming merge window closes (I don't like
> merging new functionality into -next at -rc6).

It's a bug fix, not a new feature IMHO.

I'd like to take it via the powerpc tree.

cheers
