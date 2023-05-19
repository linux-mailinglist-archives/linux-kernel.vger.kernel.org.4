Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F56709570
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjESKxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjESKxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:53:44 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55401E6B;
        Fri, 19 May 2023 03:53:43 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-530638a60e1so2879765a12.2;
        Fri, 19 May 2023 03:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684493623; x=1687085623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajFJ48fmtUSp4skMhzj/7YQeP1JQNLEyRY3cF/LDql8=;
        b=Aj+tL7aqW5ixdtpHbLQf7G4tDX5NUJluKjGQRqPFdhZuqa3QyNFbQvDYXjoNwpZb1I
         KlXbCivGUYQmPURgdszab3svGngD/Rs1Bhy2pi4HW+ShdhveFEykQPMzHHINQky6zmKV
         2E1tOraorigN3kg3+JH1PZ5Jg4ySO0ne+8hI6vjn353idS9QxAK5haWCLKK7ZQBDumri
         rPp68ernhiuF69NhPpospNvswNPtkUHi9vxQLItP395LnLHPudtik8L1hlAy+xD+jM0c
         RuPLqfTtN0voIvV9V9hWb/VSTqiC4HGMV1dp2MoRehpYa80wi/ZjS/nV/1AB/uuQUkhF
         aUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684493623; x=1687085623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajFJ48fmtUSp4skMhzj/7YQeP1JQNLEyRY3cF/LDql8=;
        b=Wgqcljg2+7iPbTt6BYzRrwFV8iu9KpjrFI2pTxHf0dwf+F/J9fm0sDkW6eWs0oI8Ak
         VpGxFFMtM6KNvyUxe2bGkYAZ9JJT15+fSsTZT49UjAmXqU4ERSBkIyXnVi34MeQUg7VM
         Jyrekex7PiT+ufuOonRWKRs53XmY/IL3s547YDGVTUw/r8tpyFKjTJOFdRLzihvv/X9j
         5twZr4zucHO2iSVgMj2n2B2zDsSkAGZc1VJ1kLaqX553Ggp2FsPgxiptDS8zjqGzK8NT
         x2wqS8xQO+muuCGt9ChBvjB9xlP4CTna1NQ/ke4+6t5X1XTBH56NLDI8W6Oyiwv03TdH
         BJMw==
X-Gm-Message-State: AC+VfDyx5DpPVsfaaEc4QQxrcmkkQdzMoylDip4Fs3OLlHrxu2vPdXHA
        yRb9YrKe7PqJ93Ob54DSaMs=
X-Google-Smtp-Source: ACHHUZ5X9bAfTBvV8GBrU/XIXgqyTaBQiMONfy79cfEJcVUpPl1q/jXU/GQFSC/adSpDazqg05bD5g==
X-Received: by 2002:a17:902:eacc:b0:1aa:f78d:97b7 with SMTP id p12-20020a170902eacc00b001aaf78d97b7mr2296338pld.46.1684493622796;
        Fri, 19 May 2023 03:53:42 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-97-28.dynamic-ip.hinet.net. [36.228.97.28])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902c08600b001ae365072cfsm3107840pld.219.2023.05.19.03.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 03:53:42 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     simon.horman@corigine.com
Cc:     alexandre.torgue@foss.st.com, davem@davemloft.net,
        edumazet@google.com, joabreu@synopsys.com, kuba@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, minhuadotchen@gmail.com,
        netdev@vger.kernel.org, pabeni@redhat.com, peppe.cavallaro@st.com
Subject: Re: [PATCH] net: stmmac: use le32_to_cpu for p->des0 and p->des1
Date:   Fri, 19 May 2023 18:53:38 +0800
Message-Id: <20230519105338.4793-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZGcs1sdy0RTrwNby@corigine.com>
References: <ZGcs1sdy0RTrwNby@corigine.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

>>  
>>  	if (likely(desc_valid && ts_valid)) {
>> -		if ((p->des0 == 0xffffffff) && (p->des1 == 0xffffffff))
>> +		if ((le32_to_cpu(p->des0) == 0xffffffff) &&
>> +		    (le32_to_cpu(p->des1) == 0xffffffff))
>
>Hi Min-Hua Chen,
>
>I'm not sure if it makes a meaningful difference in practice - and
>certainly it won't on LE systems. But I wonder if it's nicer to do the
>conversion on the constant rather than the variable part of the comparison.
>
>		if ((p->des0 == cpu_to_le32(0xffffffff)) &&
>		    (p->des1 == cpu_to_le32(0xffffffff)))

After reading your suggestion, I think:
the 'p->des0 == cpu_to_le32(0xffffffff)' gives the readers a hint that
p->des0 is __le32 type and I think it is easier (for me) to understand
than 'le32_to_cpu(p->des0) == 0xffffffff'

I will submit v2 for this, thanks for your comment.

thanks,
Min-Hua
