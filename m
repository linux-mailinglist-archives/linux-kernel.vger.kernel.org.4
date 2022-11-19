Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D39630878
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 02:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbiKSBdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 20:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiKSBcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:32:41 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB79115D01
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 16:37:33 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id k22so6393729pfd.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 16:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqG09mkEzdQHCKSzSEmyl/u3LpiENnPKSBfep8+TELk=;
        b=FrYhvC5W71DrNk8gagVsG+b26lBAjW0O8X/bMJZrcTpZuCTEuRdPrDHA3eWFnVImei
         V9SfzXlbgAWEjmBoliD9ON6kauCWmcK9OzMoJWwz7fHJUz9B5lHL0ubFUT6VCcH8q11q
         nKFlPkFGs7nzwrJmJ6s7vwg7U6uQ/cCvnFZ3b8ZawTR8q7W1jP501MDu1FK7jE1XA8F4
         SYYnLOUyS6MSHO6NclSn3R9vV6nVHxeSGaHAP+vHJgo4vhzL/1svRYSQdL22nI9d26W1
         V9CIpHei/PwqK9YhsMmwfwkQ68bgzPMIrurPg+rD1V9PJk9aU0i904wol515mkrpkDnr
         Ufpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqG09mkEzdQHCKSzSEmyl/u3LpiENnPKSBfep8+TELk=;
        b=2bVQFpBJ26O85DIyvuPf4XsUC6L+oqN19n5af6VrJ7k9UYPGl4Ryh+PHZSgCvjIlrK
         Q/vUTW43fG0/G6X2baS1ItBqClfPyFNceAB96FogbbwQW3Y39+lrksFs5TV/VbgogoBB
         lQhAP9g7CTezwrPLlxUY6ZzIYVVPFH0jAY1+uHy2sdnO1QE131MqYlgyFEPOxb+BXcy6
         2COvCx6DYV3SwbJ+nE3P1+33wvGdn2QH/GNPzd0NMOcaDKrmKF8EuYd9eERwmyLgw4tf
         SgWWZFpUecu7ek66t2r7UD2EI0oDucKo1SqnsWCjTgdq8ef61yxclipDxUFj8EGq65z0
         oPBw==
X-Gm-Message-State: ANoB5pnyz42dQ4f3leZ0MwbqT6F+jqJ+Qel9yJ2oLUwxZA7vPeHpVzCP
        FUSZLs1nvZmf0pnkF+MZffQ=
X-Google-Smtp-Source: AA0mqf4wC0j3vuw/ZJsQUMZUp/HpfM7cR67mTPKHxVISRpldeWMMhUsRA0IxjEl+zk8KuwLLP0NLAw==
X-Received: by 2002:a05:6a00:22ca:b0:56e:64c8:f222 with SMTP id f10-20020a056a0022ca00b0056e64c8f222mr10210761pfj.71.1668818252807;
        Fri, 18 Nov 2022 16:37:32 -0800 (PST)
Received: from localhost (fwdproxy-prn-019.fbsv.net. [2a03:2880:ff:13::face:b00c])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090341c500b00188fce6e8absm2628813ple.280.2022.11.18.16.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 16:37:32 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     minchan@kernel.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ngupta@vflare.org,
        senozhatsky@chromium.org, akpm@linux-foundation.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v5 6/6] zsmalloc: Implement writeback mechanism for zsmalloc
Date:   Fri, 18 Nov 2022 16:37:31 -0800
Message-Id: <20221119003731.2201964-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <Y3gJZxm3OlXmlTVj@google.com>
References: <Y3gJZxm3OlXmlTVj@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just sent out v6 of my patch that incorporates this - thanks, Minchan!
