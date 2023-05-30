Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195FC715944
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjE3I7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjE3I7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:59:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C71BE;
        Tue, 30 May 2023 01:59:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 91EE81F8D9;
        Tue, 30 May 2023 08:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685437157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G22ruJ68JY2gjnCl3J/tk16VWb8N9hrSL5V+P1DY8aw=;
        b=spkBo6kek5HXdJ+Ps51CIj7ivCB0CzLzZ+qf2jaG3s+TPpMFEjTLYiFju5XMlrBwFA1K0E
        ec6IB2UKXhlGjyv9V3BGLpIWjbbNQyPzkn3ch1fhUERosZ5blbavla1uiDgDtAG4BNJSfo
        LIQKkwdK7g7X9Ap82aOyzpqYy8KIGbg=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 12E3B2C141;
        Tue, 30 May 2023 08:59:17 +0000 (UTC)
Date:   Tue, 30 May 2023 10:59:16 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     bcain@quicinc.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, keescook@chromium.org,
        nathanl@linux.ibm.com, ustavoars@kernel.org, alex.gaynor@gmail.com,
        gary@garyguo.net, ojeda@kernel.org, wedsonaf@google.com,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Onkarnath <onkarnath.1@samsung.com>
Subject: Re: [PATCH 1/2] hexagon/traps.c: use KSYM_NAME_LEN in array size
Message-ID: <ZHW65KTxiZKHFbOZ@alley>
References: <CGME20230529111350epcas5p46a1fa16ffb2a39008c26d03c5c63f109@epcas5p4.samsung.com>
 <20230529111337.352990-1-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529111337.352990-1-maninder1.s@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-05-29 16:43:36, Maninder Singh wrote:
> kallsyms_lookup which in turn calls for kallsyms_lookup_buildid()
> writes on index "KSYM_NAME_LEN - 1".
> 
> Thus array size should be KSYM_NAME_LEN.
> 
> for hexagon it was defined as "128" directly.
> and commit '61968dbc2d5d' changed define value to 512,
> So both were missed to update with new size.
> 
> Fixes: 61968dbc2d5d ("kallsyms: increase maximum kernel symbol length to 512")

As mentioned by Michael Ellerman for the 2nd patch, the right upstream
commit is:

b8a94bfb3395 ("kallsyms: increase maximum kernel symbol length to 512")

> Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>

With the updated commit hash:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
