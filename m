Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DA966D6FC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 08:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbjAQHdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 02:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235973AbjAQHd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:33:28 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF8A2E0F4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 23:31:40 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id q23-20020a17090a065700b002290913a521so14004018pje.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 23:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRGuf3zKSLvnU9iingEuUTLd1xRFRQOujh2ZVq1MAGQ=;
        b=fNdDVZwweEaQxAfz7gQR4YECfnBWQhhDkX9H3rGpV/G+WX7L67iDyLZniEKBGwUNe3
         HAJjY9oR9Q3M7xN71bG8vEUAIgWYchbYb/5fiQBO5rs4dTlY7YIbKL08Srz8HJH/d9RL
         JMZI5SYOu7UdZ7gfAuPB07u2+RTnJBVTEYQMVw8awFStSL8vNb2uFcD8+lN0/ECq2jcA
         ioBQaQwaD+ZMGzAJBOx1mZPl9GiF55stHNKlHkXvnFWDR1/vcz0CY2GpQAg3jVR2XE/Y
         iuaIhZfhJ+wxZumaRHCRRCVECtTkyYeTR2cM2c9l3u60WsIXCAxZLsZtte2TG9L/OrIo
         fxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wRGuf3zKSLvnU9iingEuUTLd1xRFRQOujh2ZVq1MAGQ=;
        b=vVc/Xzh0INUtFL4y+U+OkUoxWv9l3YLVxwS3lmGvm+97ltssbCpc20xJc0iUzMMhun
         FrCmR0NDoNLfjATleK8ZRQZ/6gl89Cy8av9jVArhIzsAKYi0jmmcF/AMz4oD60T+5Lbx
         ju9hp5+pxwLxfiLWXhmWBnF2gvhZebnuwDY5dnJpUwRjzoSh9M9P8DP8dIA5fRbDKpYh
         FnSuMU5UMp88V/oaWlBIb7oa+ZHjQdpOPwvCEBhAjlEGMZpGX4fbJLI98kFiUMke5xQ9
         73nQj99HYY/nhsC16w7EwffLpiOfnWufD5UIgc0QoeVyjdoCK2eXGuImC+muPuo0N3+N
         Ik0g==
X-Gm-Message-State: AFqh2kptMhG4zZvnKNMfSkO8t13CDy0v+wzNF7SDdiK3y/Fbdl9gAAda
        tzwNFzXjjO8uVShGT/wLWA9Q6fX1nAIbX3lg
X-Google-Smtp-Source: AMrXdXt7VLmohgFFsYNbKMdYyjMDqbcHs08zHolF9rmgUXgt8Yb0rU76zjC1cz7WIiSG2rSovNXIlg==
X-Received: by 2002:a17:902:c3c6:b0:192:c014:f6ba with SMTP id j6-20020a170902c3c600b00192c014f6bamr2319458plj.33.1673940698630;
        Mon, 16 Jan 2023 23:31:38 -0800 (PST)
Received: from [10.90.35.114] ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001869b988d93sm13644880pli.187.2023.01.16.23.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 23:31:38 -0800 (PST)
Message-ID: <9f626aa0-cabe-8c7f-5a3c-b30ea52a6adb@bytedance.com>
Date:   Tue, 17 Jan 2023 15:31:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 3/3] memblock: Avoid useless checks in
 memblock_merge_regions().
To:     rppt@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
References: <20230113082659.65276-1-zhangpeng.00@bytedance.com>
 <20230113082659.65276-4-zhangpeng.00@bytedance.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230113082659.65276-4-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mike

What's your opinion of this patch?

Sincerely yours,
Peng.
