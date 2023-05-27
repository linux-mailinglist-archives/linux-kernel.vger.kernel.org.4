Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D584F7136F2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 00:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjE0WEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 18:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjE0WEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 18:04:51 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B24BD8
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 15:04:50 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f68fc6b479so21159895e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 15:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685225089; x=1687817089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6aJ3W4JUrbaZ5i9Ahsaa8PwDNjJDadq1BqyuxArmyHk=;
        b=U2Zq4viLBW+RhOEc9qyrUHc+tN4dZ3dJpTWk+dSYj672z/Ua5iig7bqmkx5dhtp4Ot
         lu6qeDv48PPnGRm5sKcXghUnzMEP/BvRrp47Txs9YgsV93lNLga4jNwrEzQ5oQTS4b3C
         UOOH+ORVIyYz/fBiFvnmFN0UzTQ5X/7dw8fubMVz1JGIvbxRG9ZwIPPO3Npcq4yPui9Y
         CcbQnfLTVj8I4CbNRmN0q73SoZKUchS+5XH/CgoHQAS6rWcEWiMnL7jr7BISFxi/Phsd
         XmtR1Hlr/SfYQsePqxkg4U+0O73HNedT0mqWu+lVW5WroMekQOyDcT5XU3J4dqJaiZXf
         HI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685225089; x=1687817089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aJ3W4JUrbaZ5i9Ahsaa8PwDNjJDadq1BqyuxArmyHk=;
        b=VkP0rKpK5a9bs6g6QDf9lwVGp+TfuBRpIAnSMIzp49huFu4fio6ogbVbSLTkmMnM/q
         1fOVFLqMzDdTwDuPutpGBnooMe0DYNqltB0CvR7ujWwS0m822jgnZt/im3XBYXnWfNF2
         fvq6WVl3eFyO4TpE9hb04l5EIh741QHU1umOD+R5SGqZ4eNBpUCT8Y1+fsoYFBpEgjmq
         t2YnQ4xH2yA86jY8Te0HIGn60O55buUjiAcI7JCkQhJ8wppF7ddreQydZWqpEvKcWMvj
         JtmHvodpEGSvKPLkNimoWBLnZfr+0nUN6RIBDF+cuI6dn3xDSPdoXa87t4SSOMIeRG1p
         B18A==
X-Gm-Message-State: AC+VfDwDV6BRj0JQvHPXby0/SkQhrH34tKlu2XV1vVKhktbiPDWqtrEP
        LMiwnF48U6jv/A38+8UweE4=
X-Google-Smtp-Source: ACHHUZ4HM/AT727YjC2igzS7UKc+a/92AU+gSbPqYkUzDf3P1C87HJ/z9l/z2zRTUomzrGneGpnRAA==
X-Received: by 2002:a05:600c:b44:b0:3f6:8be:5044 with SMTP id k4-20020a05600c0b4400b003f608be5044mr5442678wmr.16.1685225088676;
        Sat, 27 May 2023 15:04:48 -0700 (PDT)
Received: from localhost (host81-154-179-160.range81-154.btcentralplus.com. [81.154.179.160])
        by smtp.gmail.com with ESMTPSA id w8-20020a1cf608000000b003f18b942338sm9441881wmc.3.2023.05.27.15.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 15:04:47 -0700 (PDT)
Date:   Sat, 27 May 2023 23:04:46 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH] lib/test_vmalloc.c: avoid garbage in page array
Message-ID: <b4cd1b89-5137-41e2-9430-6da2078775f8@lucifer.local>
References: <20230524082424.10022-1-lstoakes@gmail.com>
 <ZG/4gVO9XPXccR5+@MiWiFi-R3L-srv>
 <b87ff2af-c89d-4ddd-8992-2ffb337fbe0c@lucifer.local>
 <ZHB0UTEYUMZVa23V@MiWiFi-R3L-srv>
 <368bbc1d-d810-4bc4-8091-7ed55631344f@lucifer.local>
 <ZHHXUd0KPbsvrZlV@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHHXUd0KPbsvrZlV@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 27, 2023 at 06:11:29PM +0800, Baoquan He wrote:
> Yes, I digressed from the patch itself. At the beginning, I truly didn't
> understand why __alloc_bulk_array() would break the test. Sorry for
> wasting your time.
>

It's fine, no apology needed, it's fine to discuss things but I think it's
also very important to be practical about timelines for these things too.

Thanks for the tag, much appreciated!

Cheers, Lorenzo
