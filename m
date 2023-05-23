Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E087570DE37
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbjEWN4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbjEWN4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:56:33 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED32F185
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:55:53 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 41be03b00d2f7-517bdc9e81dso4055257a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684850152; x=1687442152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmHsTs7JWsoGlwzq7kUvL4H9I+t72w4NrHe/sVhcdHE=;
        b=Gg+PuTxmax4COq/lDYB9P8C/Ci1HYBkYq3Iv+8mj3PEiQir3JQLVaI3DAKl/wnV4OK
         SWKzxE7Ir5EQ43bD71NeDPjE1l6dB/L/OAOp1uaDEqWLoy5lGp8E1JT+9R47oDdXuPUx
         veKI9Jdyb8wDCMr8v2h6YQtwnSnjyzsNaUfEZ4cqYOyef5xrJ3D5b08pq4dJ8iADfp49
         3f/pLQxlyv+py57b62LJhct/lzQ8jSw/Gazmbprb/04zVGOnV906X7f6XnxZ2j6znGXK
         s1rKCNFUnSzUujWoohlR482n/qd5amAW3Ck6FfTBXCThZXixvEMJES2Luut80LfbYk9N
         eK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684850152; x=1687442152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmHsTs7JWsoGlwzq7kUvL4H9I+t72w4NrHe/sVhcdHE=;
        b=Ag3L2N3toJ2HfQyFk4KFcfWhJdJoaT+x3oxWXqnn2UTN+jxfv8gjKKVgaN058Gji8v
         HjBkhoXhY+4B2fG3h+bOwzFiMUphpEZgw0C3e+Mt6HAoLhveMv4jHp8moRz2zdo+/0Wr
         fKLZyjiNwMfIpCBS4IcSGdusqCYl4kFMp/tFwgW+5Iak4huzpMfWIl4dNziik4Nve/mp
         tZn5d0z4Dt3ro1Kq5modKnIitcL6onERiWZ/u9ZzJC+k3V2+rOiRgu9r7cJFjj7BNp0j
         6hqbFDw+hoK6OXUj/eBh08MnAH6+FCfZeY0Ihxsh7AuHgxMhTjfmUFO0kZ+ktZS/Nqll
         BlOA==
X-Gm-Message-State: AC+VfDwxC+T33XeWVBDLTdAjAMbl9mlVBcxL5QPstKL9CCEFjvl8jsfZ
        HIR72oElzUmzg5ZHgB+87Og=
X-Google-Smtp-Source: ACHHUZ4tmm7FhOCUf/TkjU9sGz8VdPGZBqifAInOa58D9BPLA4kJWaxgU5fVScIrv+He4YVnAoqL8A==
X-Received: by 2002:a17:902:6bc2:b0:1ae:6882:5bc4 with SMTP id m2-20020a1709026bc200b001ae68825bc4mr12277090plt.64.1684850152470;
        Tue, 23 May 2023 06:55:52 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m4-20020a170902db0400b001aaec7a2a62sm6799139plx.188.2023.05.23.06.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 06:55:52 -0700 (PDT)
From:   xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     david@redhat.com
Cc:     akpm@linux-foundation.org, imbrenda@linux.ibm.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com,
        xu.xin16@zte.com.cn, yang.yang29@zte.com.cn
Subject: Re: [PATCH v8 1/6] ksm: support unsharing KSM-placed zero pages
Date:   Tue, 23 May 2023 21:55:47 +0800
Message-Id: <20230523135547.6819-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1925d301-462d-6b33-8867-4e1646b2dbd6@redhat.com>
References: <1925d301-462d-6b33-8867-4e1646b2dbd6@redhat.com>
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

Excuse me, I'm wondering why using inline here instead of macro is better.
Thanks! :)

Thanks for reviews.
