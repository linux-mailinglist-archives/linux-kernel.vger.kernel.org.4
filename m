Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46D165610A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 09:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiLZIPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 03:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLZIPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 03:15:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B6E25F1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 00:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KEzaiQEjAdz4nbUPM7Aak00E/TFfUXezSTFVBGEzDzc=; b=ZQdPMoDX0iZzTwb+WbGZ/SoFGd
        5TA6PBrL14a5Ga68dPnk9oP2lfgAhokIj+G9gCcY6i1ObwRr8k6AZK2uYuDpPVSjpedKXDhNFJWuE
        IgbI+FVvfg5JcuniWiWsgK+mrmgVKXOlkFR1kN7A3uDbNQaU1aqEuyfl3FNRQwuCVEjSwRpau99Xm
        ++UpHd8gJ0RLy0v6lOZvHPVnfeF3fCiXSM7NxgxQUsh6hfhppUGHmqoTm+dtyJcNXpAJ7ioDDAyDZ
        o/mIKjm4G99PkME/K1NPfjBj+pOXX5PO9dd8em3GGpLbHhEdX0u7aJ73rprTJP5XvuJPlo7W6JRn7
        Ml3XiduQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p9idt-006WMo-RH; Mon, 26 Dec 2022 08:15:29 +0000
Date:   Mon, 26 Dec 2022 08:15:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <liam.howlett@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 3/4] mm: mlock: update the interface to use folios
Message-ID: <Y6lYIfVAf+EZa/Lb@casper.infradead.org>
References: <cover.1672038314.git.lstoakes@gmail.com>
 <555c36b91c4b34a5972f2614395e3c3831e8102f.1672038314.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <555c36b91c4b34a5972f2614395e3c3831e8102f.1672038314.git.lstoakes@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2022 at 07:08:46AM +0000, Lorenzo Stoakes wrote:
>  			goto out;
> -		page = pmd_page(*pmd);
> +		folio = page_folio((struct page *)pmd_page(*pmd));

I do not like this fix.  Better to fix m68k to:

#define pmd_page(pmd)	(struct page *)NULL

