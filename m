Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C194E6EE559
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbjDYQOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbjDYQOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:14:02 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038779022
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:13:59 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-94f3df30043so945246066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682439237; x=1685031237;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhT3n3uvVNiweRdZg9pUZ8/lOKMThAVg4Q85EU6X5VE=;
        b=WFfs6WxKY1IQFGgDPzf2iHSWqrenokOc5Gt4EFNBJCATVwkBuNSKk8RfPWXzsygHj3
         a8Bg6AWXaz3GvPqyrnaaEv9N253Le/BkpCxcx5AAB7dWLjCFDeU0rOab3M2oi+yA+FSS
         8cBYrzaoV1VWNbSniYDgsLLCg81zPXgDXtLVvHkkmEzgN7VpiqHboUotZuLVb2jfrWD8
         U0+ipdpWSQTM55pjMR64xGo3RIT3h/kVw7vlqjXerAqL9e+c/iohxMmwUs4nDy7B59qH
         JrkwWwxtOArHeevA+K1jZquAY3eNOgFsbEJ530+NxU9ww6AkpJeZ7VdlvsXqKY8sEFvj
         vmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682439237; x=1685031237;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XhT3n3uvVNiweRdZg9pUZ8/lOKMThAVg4Q85EU6X5VE=;
        b=NcPH3uhSPllaApEb5v77lW9+NPgJJ0GPvekxi9YfWigLvSC8OS4rR2/6434DQ2zWPz
         jmPItwP0Ki+FCTx6WlOTEan7pJCe5ZQu1Qsnp9oHB+vATglcLqu1hGn0z0TbcCf+cfqb
         79oN+TnVkZtwC1nWNOzVm0WSjwcpWS7tWBjyZj8CumERENNbe+4WZNCr8TBv/d9nOWHp
         zDy78672ABjI7QJ0ujtmtMJzIPDzPGTrGx3O+SUfwPsDHVx3CegZu8ch6Ze12fiUB1w4
         3tjP0cr2sWxlwjw3rc9YtXQCnY0+asDDbNQO03uJnWSr4vPyaV1Hme1jBlRFDotCeJQw
         KHFQ==
X-Gm-Message-State: AAQBX9e6NKTIpsqF1orjnqXQUZoTQd0/7hx6Eu3HyUlPeqKloHZKH0Ti
        C0PXAWOyEJd0BO68EFaj9Gw=
X-Google-Smtp-Source: AKy350apXHXANa6lU99sj9JOBLwy3DdpJ+lJXgTkFgVLybI2PXebggl09hdoFLNDuyzfwuS7xrcUvw==
X-Received: by 2002:a17:907:168d:b0:953:4775:baa7 with SMTP id hc13-20020a170907168d00b009534775baa7mr16049654ejc.52.1682439237379;
        Tue, 25 Apr 2023 09:13:57 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id s22-20020a170906169600b0094f3132cb86sm6897083ejd.40.2023.04.25.09.13.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Apr 2023 09:13:56 -0700 (PDT)
Date:   Tue, 25 Apr 2023 16:13:56 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH 02/34] maple_tree: Clean up mas_parent_enum()
Message-ID: <20230425161356.yfjhn2uoq32pbp6r@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
 <20230425140955.3834476-3-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425140955.3834476-3-Liam.Howlett@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 10:09:23AM -0400, Liam R. Howlett wrote:
>From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
>mas_parent_enum() is a simple wrapper for mte_parent_enum() which is
>only called from that wrapper.  Remove the wrapper and inline
>mte_parent_enum() into mas_parent_enum().
>
>At the same time, clean up the bit masking of the root pointer since it
>cannot be set by the time the bit masking occurs.  Change the check on
>the root bit to a WARN_ON(), and fix the verification code to not
>trigger the WARN_ON() before checking if the node is root.
>
>Reported-by: Wei Yang <richard.weiyang@gmail.com>
>Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me
