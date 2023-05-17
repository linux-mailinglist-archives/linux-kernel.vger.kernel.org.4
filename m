Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814267070F7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjEQSkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjEQSkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:40:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296232134
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 11:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684348785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wDwTEAQnINvjnEbZP5xDG/iVDh3xkCCQxQmpV/hFkq8=;
        b=HmfBCIVTWAzz4snI7bktNdvBBivfQygPNLS3sx9/bj42lZiAjHWJinikqhCniXsHO/Nmwq
        R7XTN0PukI5/XfQsVRy3vnoSmehA6JP5aI7cnOhrETxNYPUdIbSiQcq2afggperHY/6Zr/
        juBO91pv0QUrdZvgcG8PELz9h7s/2EU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-H9rUM7MzN26fqPeq_pkUHg-1; Wed, 17 May 2023 14:39:42 -0400
X-MC-Unique: H9rUM7MzN26fqPeq_pkUHg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3f393bf5546so2287841cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 11:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684348781; x=1686940781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDwTEAQnINvjnEbZP5xDG/iVDh3xkCCQxQmpV/hFkq8=;
        b=MNxublco28Hqym4Y6sRGt/FNll/nsIGig2yCQXcExmnK81LRrbgmdKYP/s+WFMYVlT
         AU5+Zooayt/tHjOoexJ8WwagdJ4zePCqcIBdyDWV0XgLW7joUzNqCMZD8B+y5YqvO++W
         7vf+sPYKUKtPhlh40dYHPq+EMFRR0PpxobNzIcWMm/NlNIB//Bom650sYnzNTgHnhCTs
         17NJXEVVMcpzAPZ9OkJ7kDBTOoEtIZ8SXV8Bd5yCqjh2ZM8m7haff6TXxWcBxNnXbjnB
         n3Nziy4wn4fE7eKc7EouRDWBHW67d4u/FOMUIGAvaq71QYvorTWSgW9UEBr8JXq8GqGY
         pQng==
X-Gm-Message-State: AC+VfDzeuojqcJwuauCF/yVIAT1CaNabtZA5gZWrdqM04x18OiZ5j53U
        WU9ktDQKBgSrB4Ub12t6jX7GXBRizEdbe8Xnmun+5JfyDanHXU60cLUfqlR5Ld7aCmQG8XNO1/W
        L1oRMTi1BMvDyGRcxMNLM5GBR
X-Received: by 2002:a05:622a:189e:b0:3f5:99e:d7d4 with SMTP id v30-20020a05622a189e00b003f5099ed7d4mr6386662qtc.1.1684348781423;
        Wed, 17 May 2023 11:39:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7npnxMYaFPMdez4XnpRaMmAS6FkMcdldYw8nV0EQ28btS8JdEbLrqbrGm2Y5o1ja5g9B0pJQ==
X-Received: by 2002:a05:622a:189e:b0:3f5:99e:d7d4 with SMTP id v30-20020a05622a189e00b003f5099ed7d4mr6386634qtc.1.1684348781213;
        Wed, 17 May 2023 11:39:41 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id k21-20020a05620a143500b0075954005b46sm814944qkj.48.2023.05.17.11.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 11:39:40 -0700 (PDT)
Date:   Wed, 17 May 2023 14:39:39 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-stable <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm/uffd: Allow vma to merge as much as possible
Message-ID: <ZGUfa+E+LNZWmJGi@x1n>
References: <20230517150408.3411044-1-peterx@redhat.com>
 <20230517150408.3411044-3-peterx@redhat.com>
 <a23dc138-a7b3-40c7-adf9-68b2c8185e08@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a23dc138-a7b3-40c7-adf9-68b2c8185e08@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 06:23:18PM +0100, Lorenzo Stoakes wrote:
> Maybe a Reported-by me since I discovered the fragmentation was already
> happening via the repro? :)

Sure!  I'll add it when/if there's a repost.  Thanks.

-- 
Peter Xu

