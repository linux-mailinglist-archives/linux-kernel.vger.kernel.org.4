Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862AE69B345
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 20:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjBQTpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 14:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBQTps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 14:45:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D635E58E;
        Fri, 17 Feb 2023 11:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HznwluzS0ZGoZBxqPywPydMAJ7rtE7A0nySFqvQCNKU=; b=ZdlZ/53k/mtRuNZKjJ/V0nzM18
        NQTuOZpFnJ1UXH8JSdVoqCOQuGuckB9rvIbuhwkxblJF8okMMFOe5fO3WQtWVGHG4W3e79OPKnUw9
        26h8mXYKiump0wSLoHk8KXdAuEEfYfdBdREBp+us9n7Z2hmECRNeFVpWFIilk3vMRaxhuTJV4VZ9T
        lyXv7TuLS4kOjbKcS11XQxqX98tEli6YJxVDyIJXKtCr4TyZCPmoqfY8Cy52o+qA3fha9fF2csXwu
        uYYs0E1ZnYV5NnP2hf0BS+FhyAxwbVmh4Q90+i8SWHbfPPkovS3KuJi2m7fLbdfZQXf8JuGL1QyBo
        QXdQ88XA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pT6fj-009a9i-Q7; Fri, 17 Feb 2023 19:45:31 +0000
Date:   Fri, 17 Feb 2023 19:45:31 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        matthew.brost@intel.com, boris.brezillon@collabora.com,
        alexdeucher@gmail.com, ogabbay@kernel.org, bagasdotme@gmail.com,
        jason@jlekstrand.net, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-next v2 03/16] maple_tree: split up MA_STATE() macro
Message-ID: <Y+/ZW/8WXzrkQnUT@casper.infradead.org>
References: <20230217134422.14116-1-dakr@redhat.com>
 <20230217134422.14116-4-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217134422.14116-4-dakr@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 02:44:09PM +0100, Danilo Krummrich wrote:
> \#define SAMPLE_ITER(name, __mgr) \
> 	struct sample_iter name = { \
> 		.mas = __MA_STATE(&(__mgr)->mt, 0, 0),

This is usually called MA_STATE_INIT()

> #define sample_iter_for_each_range(it__, start__, end__) \
> 	for ((it__).mas.index = start__, (it__).entry = mas_find(&(it__).mas, end__ - 1); \
> 	     (it__).entry; (it__).entry = mas_find(&(it__).mas, end__ - 1))

This is a bad iterator design.  It's usually best to do this:

	struct sample *sample;
	SAMPLE_ITERATOR(si, min);

	sample_iter_for_each(&si, sample, max) {
		frob(mgr, sample);
	}

I don't mind splitting apart MA_STATE_INIT from MA_STATE, and if you
do that, we can also use it in VMA_ITERATOR.
