Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E936EECEB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 06:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239327AbjDZEP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 00:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239023AbjDZEPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 00:15:24 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23591990
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 21:14:58 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1a50cb65c92so52845495ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 21:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682482498; x=1685074498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f12XBIeKD4zCA/Sk8xAhXMMryIXAoPgMmXZoc14vR/g=;
        b=FkmPAVs59CIIhjmSzFCOHZImQx2lDgBhy6/um/D0WIY8srLhctqucVObwj5qoSl1PF
         xkIOlpuHs4Cv022AqonMwPBtq6wKe8ObxRYOs9E+lAr2TEVvHHnI7Xje0O8S53XUFM63
         f7C19kKqS2NJvJ/5bVz/ONQtRvkjAdq0EU84StTVTaRCxBAVv6F6fdwWsF1K0OJuVS0h
         hbF0APkjnsJ78cx28KHF4/qDBj6PpuseQpSzaANmB+EI5J2uNe6vIUkmFN67ow5peLYm
         CvuAZiVzXKBUr30MC0HfA+IIH6HJyJWRcbZG7DOJ7OiVGb7dnBdKOoEvz8TSGYHEzwz8
         tvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682482498; x=1685074498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f12XBIeKD4zCA/Sk8xAhXMMryIXAoPgMmXZoc14vR/g=;
        b=mGMzllLBoI0CK1fbMP6MohqC5aeHJy4MGROROpE8AKVk3r2nbNRr5zfFa2f9lFEUEZ
         Atxbw+hZsIUf7GZgM/+Cf1LRoa1t8kYoWWka5/12MvBDj1OG4kK837O5MZbiIfCbVCG7
         Ruy/i7FAEKbcu/PUoNyrPbLAMOIvQZxMbOf3go/6vg70QGj6AA3HHLeYj3ONcCpKSBYc
         EE/ecWpfHXZ0mDxHWV7EfGT0QtklNKVllQ+q0Uc7r6YNO4BFqu6y/8g8UqS7pzy7PTDS
         F7GCpyZVsv7uXrglKCY0E3mQLATEm6kXUS4vfXBRSixqd4LNOoX5qJDHX4l7SRfg/kGz
         zvaA==
X-Gm-Message-State: AAQBX9ctu0/bTb9JWF9IT8X9GrEfdaoAGgSDLnMm9jAcis62l/wJGRlW
        VyEtKu+tbW/CYfIyvEVSPt12BA==
X-Google-Smtp-Source: AKy350ZnwYrxiExp3wU2Qo5QoKE+PvB9AhN3LOXeWKZXGg9E7DIcBU4VEgZ4th+Ae0IrQgs6ziSniA==
X-Received: by 2002:a17:903:244f:b0:1a8:16d2:a867 with SMTP id l15-20020a170903244f00b001a816d2a867mr25713859pls.62.1682482498248;
        Tue, 25 Apr 2023 21:14:58 -0700 (PDT)
Received: from [10.200.11.252] ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id ji9-20020a170903324900b001a1d4a985eesm8980274plb.228.2023.04.25.21.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 21:14:57 -0700 (PDT)
Message-ID: <75ebddd7-641f-0274-72c5-415007d60cdd@bytedance.com>
Date:   Wed, 26 Apr 2023 12:14:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH 02/34] maple_tree: Clean up mas_parent_enum()
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        Wei Yang <richard.weiyang@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
 <20230425140955.3834476-3-Liam.Howlett@oracle.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230425140955.3834476-3-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/4/25 22:09, Liam R. Howlett 写道:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> mas_parent_enum() is a simple wrapper for mte_parent_enum() which is
> only called from that wrapper.  Remove the wrapper and inline
> mte_parent_enum() into mas_parent_enum().
>
> At the same time, clean up the bit masking of the root pointer since it
> cannot be set by the time the bit masking occurs.  Change the check on
> the root bit to a WARN_ON(), and fix the verification code to not
> trigger the WARN_ON() before checking if the node is root.
>
> Reported-by: Wei Yang <richard.weiyang@gmail.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>   lib/maple_tree.c | 28 +++++++++++-----------------
>   1 file changed, 11 insertions(+), 17 deletions(-)
>
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 9cf4fca42310c..ac0245dd88dad 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -428,25 +428,23 @@ static inline unsigned long mte_parent_slot_mask(unsigned long parent)
>    * mas_parent_enum() - Return the maple_type of the parent from the stored
>    * parent type.
>    * @mas: The maple state
> - * @node: The maple_enode to extract the parent's enum
> + * @enode: The maple_enode to extract the parent's enum
>    * Return: The node->parent maple_type
>    */
>   static inline
> -enum maple_type mte_parent_enum(struct maple_enode *p_enode,
> -				struct maple_tree *mt)
> +enum maple_type mas_parent_enum(struct ma_state *mas, struct maple_enode *enode)

Do you think it's better to rename this function to mas_parent_type()?
The meaning of enum is not obvious and there is already a similar
function mte_node_type().

>   {
>   	unsigned long p_type;
>   
> -	p_type = (unsigned long)p_enode;
> -	if (p_type & MAPLE_PARENT_ROOT)
> -		return 0; /* Validated in the caller. */
> +	p_type = (unsigned long)mte_to_node(enode)->parent;
> +	if (WARN_ON(p_type & MAPLE_PARENT_ROOT))
> +		return 0;
>   
>   	p_type &= MAPLE_NODE_MASK;
> -	p_type = p_type & ~(MAPLE_PARENT_ROOT | mte_parent_slot_mask(p_type));
> -
> +	p_type &= ~mte_parent_slot_mask(p_type);
>   	switch (p_type) {
>   	case MAPLE_PARENT_RANGE64: /* or MAPLE_PARENT_ARANGE64 */
> -		if (mt_is_alloc(mt))
> +		if (mt_is_alloc(mas->tree))
>   			return maple_arange_64;
>   		return maple_range_64;
>   	}
> @@ -454,12 +452,6 @@ enum maple_type mte_parent_enum(struct maple_enode *p_enode,
>   	return 0;
>   }
>   
> -static inline
> -enum maple_type mas_parent_enum(struct ma_state *mas, struct maple_enode *enode)
> -{
> -	return mte_parent_enum(ma_enode_ptr(mte_to_node(enode)->parent), mas->tree);
> -}
> -
>   /*
>    * mte_set_parent() - Set the parent node and encode the slot
>    * @enode: The encoded maple node.
> @@ -7008,14 +7000,16 @@ static void mas_validate_parent_slot(struct ma_state *mas)
>   {
>   	struct maple_node *parent;
>   	struct maple_enode *node;
> -	enum maple_type p_type = mas_parent_enum(mas, mas->node);
> -	unsigned char p_slot = mte_parent_slot(mas->node);
> +	enum maple_type p_type;
> +	unsigned char p_slot;
>   	void __rcu **slots;
>   	int i;
>   
>   	if (mte_is_root(mas->node))
>   		return;
>   
> +	p_slot = mte_parent_slot(mas->node);
> +	p_type = mas_parent_enum(mas, mas->node);
>   	parent = mte_parent(mas->node);
>   	slots = ma_slots(parent, p_type);
>   	MT_BUG_ON(mas->tree, mas_mn(mas) == parent);
