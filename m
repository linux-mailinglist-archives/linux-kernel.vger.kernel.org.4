Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C41746632
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 01:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjGCXcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 19:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGCXcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 19:32:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0217C137
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 16:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T9FI83Ur/A9H8bnhCFZUzb7scpiDs9V+6FiDlWpLnpA=; b=X1jPdpxtNWH9nZx7CmSlW42aWa
        yX3MEthOI1xIgbeiAYE8OL3gE9Z11T16zC5HKFw8zwCWSM6FLHv11kEvMOqOPvflzZDiNDbcPMQvQ
        n/B7+H6DImjKJv3VPixCyuINvBCDGT8gngjTnpSbpsx2gEtcD3xrOiqkDrx6awZxEaMsumTDlsMM6
        1/QVlNzjU+zMPNiJkt3+HkBgOLSGxlTTBrJwUm/L9M+vOwOChFKNiqPsvoRbrvqZRqAQXvr0z6ZqF
        iNGaBKhjfB7p+LPHPENPg0Op51/0B2p1Wz63c30GJ34AS11Cj1xZazcsN/lAIphZxWVhxmD31Dfgm
        l1/zIv4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qGT26-008czC-VB; Mon, 03 Jul 2023 23:32:39 +0000
Date:   Tue, 4 Jul 2023 00:32:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 4/4] mm/memory: convert do_read_fault() to use folios
Message-ID: <ZKNalsGGwdXWLGSO@casper.infradead.org>
References: <20230703055850.227169-1-sidhartha.kumar@oracle.com>
 <20230703055850.227169-4-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703055850.227169-4-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2023 at 10:58:50PM -0700, Sidhartha Kumar wrote:
> +++ b/mm/memory.c
> @@ -4528,6 +4528,7 @@ static inline bool should_fault_around(struct vm_fault *vmf)
>  static vm_fault_t do_read_fault(struct vm_fault *vmf)
>  {
>  	vm_fault_t ret = 0;
> +	struct folio *folio = page_folio(vmf->page);

Similarly, vmf->page is not initialised until after __do_fault().

