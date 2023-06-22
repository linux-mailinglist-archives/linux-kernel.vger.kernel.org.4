Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A421473A983
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjFVUcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 16:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjFVUcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:32:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DFF1FF0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 13:32:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3A8D617AA
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 20:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66DEC433C8;
        Thu, 22 Jun 2023 20:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687465926;
        bh=UIN7vbEVF4QwHSBcKRVm9rZeEKOWGNBryfxnm2JqxHc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VfzrcJNDTADNxZLzWKciLQRYu+9nq1/G4islfOdNF43uWQdxT0kHF3tQn9mCixHWV
         xZTEn3AWgWdN4D/DB+CFPlVlwmLV3DRAVex3AkpjMh5zJoxWP6nHE0SW80Qe0Kgza+
         ZJP8xwy2+AR/jv9XxjkMYN+jy48KK83wZAW4YLbTPfk5Cl9PpWhFov9dzd6wQ8DHMb
         i2liKBmsuV0ZGkdNCWEP08f9OnIYIhkDiAsHtFtPqU+mSE3gOFsZ1HhsBVF/y6jdce
         NeKzNaf3EJQfx8sThzuALfLD5h04GAVz4kw8ZOmCPRR+sGgFdSWInuoElCE5RKW8uj
         NSfvuvNQVY51g==
Date:   Thu, 22 Jun 2023 13:32:04 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Maxim Kochetkov <fido_max@inbox.ru>
Cc:     netdev@vger.kernel.org, Robert Hancock <robert.hancock@calian.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Michal Simek <michal.simek@amd.com>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] net: axienet: Move reset before 64-bit DMA
 detection
Message-ID: <20230622133204.2ba95c21@kernel.org>
In-Reply-To: <20230622192245.116864-1-fido_max@inbox.ru>
References: <20230622192245.116864-1-fido_max@inbox.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023 22:22:45 +0300 Maxim Kochetkov wrote:
> 64-bit DMA detection will fail if axienet was started before (by boot
> loader, boot ROM, etc). In this state axienet will not start properly.
> XAXIDMA_TX_CDESC_OFFSET + 4 register (MM2S_CURDESC_MSB) is used to detect
> 64-bit DMA capability here. But datasheet says: When DMACR.RS is 1
> (axienet is in enabled state), CURDESC_PTR becomes Read Only (RO) and
> is used to fetch the first descriptor. So iowrite32()/ioread32() trick
> to this register to detect 64-bit DMA will not work.
> So move axienet reset before 64-bit DMA detection.
> 
> Fixes: f735c40ed93c ("net: axienet: Autodetect 64-bit DMA capability")
> Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
> Reviewed-by: Robert Hancock <robert.hancock@calian.com>
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Quoting documentation:

  Resending after review
  ~~~~~~~~~~~~~~~~~~~~~~
  
  Allow at least 24 hours to pass between postings. This will ensure reviewers
  from all geographical locations have a chance to chime in. Do not wait
  too long (weeks) between postings either as it will make it harder for reviewers
  to recall all the context.
  
  Make sure you address all the feedback in your new posting. Do not post a new
  version of the code if the discussion about the previous version is still
  ongoing, unless directly instructed by a reviewer.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#resending-after-review
