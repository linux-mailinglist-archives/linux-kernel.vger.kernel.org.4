Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F88750726
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbjGLLwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbjGLLvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:51:54 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1FE213D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:50:18 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-666eb03457cso4059555b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689162581; x=1691754581;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDe08sgS7sFUpP7IJqIHDN8PvjqaawcT5zRrNwi9z5o=;
        b=VVe6u4GG0tg4LY7qJnVHghjDZYMVqPnUq2/2FKOOEX5bTAH4BfHDFVg65I0PSJSSKI
         sHuAZAcrJTRY1hNXSmY3xxIC034A2ropQdK14coLIbbORv9WKJj3eX8mQ2uic8P+pIuw
         Vz83nr8MKU5G96nUk96+jqaVGOypuDiyGSWVyYUubzVQbBVGEtTmryJJNZGfD5NcInsd
         m2f4HnJAMAQU5ak5MPfQ0DWnbT1e0GsZWSqf33HmkTZOrcbkUi8eRSA+Ys4gDe/J+ZGC
         30GB1bzMf18iernXdy6wbrx0DXIwbntBn4N3aaGYo+kkNmN+hZpH3JXGcs+8pWIorJkA
         ORNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689162581; x=1691754581;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GDe08sgS7sFUpP7IJqIHDN8PvjqaawcT5zRrNwi9z5o=;
        b=JaroQhp7SSwlhCB1zPs9cHOlYE3WGodu39nCnpayY2MllDwOj9GnY3GZZh1543FbGO
         tavxZlvlAPcFrG3AS3U00+sjw5BEi9lpkIadfxcHKK/Q2O1P6k+pdS1yLvtfqDuG4iRA
         wKJcef5BGv4bMywCsUZcifSGoBUcyKgeRzHSiRph1QuqDlHHcadw7esms9gvTugH1LTf
         sYH07etzTlZN9kPno2dg9aEfMXRZDAQhwmc6rqdzQrVHcdiq16rJmCYsY61hfptvX0zz
         0+hNuaow+8uHJBmmn4S/yvBg6+MbFcjHtJJVt3TV+cicWwtDr91x20GsbvrFGReenIuI
         TLTQ==
X-Gm-Message-State: ABy/qLbm+FVyTep5PlvLZ/xn+KEWx/eQTzyDpM7/zttuXnWvBgkdxIF1
        EZ5v4n0jLaEBI++prYZq3DxVqyl7zm4hyqyz15U=
X-Google-Smtp-Source: APBJJlEnK8LaATz66WB20bQECjbVhwX4rmEHAOugpVTgwQz3YjSu1lSaVVC0p1/d499zUsmy/XQMng==
X-Received: by 2002:a05:6a20:9385:b0:127:796d:b70d with SMTP id x5-20020a056a20938500b00127796db70dmr17472198pzh.61.1689162580884;
        Wed, 12 Jul 2023 04:49:40 -0700 (PDT)
Received: from [10.254.22.102] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id j20-20020aa79294000000b006833bcc95b0sm35082pfa.115.2023.07.12.04.49.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 04:49:40 -0700 (PDT)
Message-ID: <463899aa-6cbd-f08e-0aca-077b0e4e4475@bytedance.com>
Date:   Wed, 12 Jul 2023 19:49:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: Maple Tree Work
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>,
        Danilo Krummrich <dakr@redhat.com>,
        maple-tree@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230707163815.ns4kdz7iut5octjv@revolver>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230707163815.ns4kdz7iut5octjv@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/8 00:38, Liam R. Howlett 写道:
>   - Fork & Dup tree + Delete DONT_COPY
>   	This is to optimize dup_mmap() in kernel/fork.c, but other
> 	users may want faster duplications of a tree.
> 	This should be faster than building a tree in bulk mode.  The
> 	idea is to just copy each node and replace the pointers in,
> 	probably, a BFS order.  Once the leaves are reached, the VMAs
> 	will be replaced by the copies made in fork, unless DONT_COPY is
> 	set, in which case the VMA will be deleted from the copied tree.
> 	DONT_COPY is not common and since the tree isn't visible, all
> 	nodes should be available for reuse (no RCU worries).
If DONT_COPY is set, this method will be complicated, because the gaps
adjacent to it need to be merged, and the gaps of all ancestor nodes 
need to be updated.

I have another idea to build a tree, if inserted in order, we only
insert at the leaf node. All leaf nodes are connected using a linked
list. In the end we get a linked list with only leaf nodes. Then we
construct non-leaf nodes layer by layer from bottom to top. I think
this is also faster than bulk mode. Another advantage of this method
is that we are applicable to more scenarios, do not need the original
tree, only need to know the ranges inserted in order. I don't know
how fast this method is, so we can discuss it.
