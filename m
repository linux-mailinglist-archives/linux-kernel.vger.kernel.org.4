Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB00E745B2A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjGCLdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 07:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjGCLc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:32:58 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630EFC6
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 04:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1688383972;
        bh=amKSxElUXOBsQ/ZeBWOs02uQ1wiOklOJIeiioUSfrbU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=cjOfTwTDAdyQWLk5OgoU+scBQqHcMgm1xrC+YKMj0qbh8OB31tJr1QzMaNC0oznvJ
         5X0JG5ai36xAcluxWkPzUNyXsx9HP7NnCyAAHIc5tCcUI0+X97GYSkWIniwW851GHM
         TLlSFRW2wZ2EMDgY2rh+blKYhn0GA7jOZEEzYZdMh551VhhBHulejM+xi7fe7g3pdV
         ydTC9xYNU76Kby9gUINFGbVxRipDDqGU6wPEVYAgO+EuxQCXEY8RgrYwWnuKhHTwzW
         JjaP823x4D8XKPAXeVOlcwaEHpocYrsmkcoXd3LMO4jkK02naIaG24u/e8dgsHSYz8
         H3wWvd3AHHkPQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvkLW1b5Yz4wZp;
        Mon,  3 Jul 2023 21:32:50 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christian Zigotzky <chzigotzky@xenosoft.de>,
        Michael Ellerman <patch-notifications@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>
Cc:     Darren Stevens <darren@stevens-zone.net>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: isa-bridge: Fix ISA mmapping when "ranges" is
 not present
In-Reply-To: <1a205224-06d4-9337-5621-c9760c02f9e5@xenosoft.de>
References: <20230505171816.3175865-1-robh@kernel.org>
 <168836167601.46386.17041701491443802315.b4-ty@ellerman.id.au>
 <1a205224-06d4-9337-5621-c9760c02f9e5@xenosoft.de>
Date:   Mon, 03 Jul 2023 21:32:50 +1000
Message-ID: <873525w7q5.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Zigotzky <chzigotzky@xenosoft.de> writes:
> On 03.07.23 07:21, Michael Ellerman wrote:
>> On Fri, 05 May 2023 12:18:17 -0500, Rob Herring wrote:
>>> Commit e4ab08be5b49 ("powerpc/isa-bridge: Remove open coded "ranges"
>>> parsing") broke PASemi Nemo board booting. The issue is the ISA I/O
>>> range was not getting mapped as the logic to handle no "ranges" was
>>> inverted. If phb_io_base_phys is non-zero, then the ISA range defaults
>>> to the first 64K of the PCI I/O space. phb_io_base_phys should only be 0
>>> when looking for a non-PCI ISA region.
>>>
>>> [...]
>> Applied to powerpc/fixes.
>>
>> [1/1] powerpc: isa-bridge: Fix ISA mmapping when "ranges" is not present
>>        https://git.kernel.org/powerpc/c/79de36042eecb684e0f748d17ba52f365fde0d65
>>
>> cheers
> Hello Michael,
>
> This patch has already been applied. Link: 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4927cb98f0eeaa5dbeac882e8372f4b16dc62624

Yes, it's actually the same commit. I'm just catching up on sending the
thanks emails. Sorry for the confusion.

cheers
