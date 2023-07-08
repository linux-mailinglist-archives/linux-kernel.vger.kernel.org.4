Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A986374BA51
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 02:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjGHABE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 20:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjGHABB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 20:01:01 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCAA2682;
        Fri,  7 Jul 2023 17:00:53 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-553a1f13d9fso1869036a12.1;
        Fri, 07 Jul 2023 17:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688774453; x=1691366453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bxgbWUBnxExDB7kpFpIZUNOmBhUx/4DiPfGLMipANHo=;
        b=RdsW/BRS0VZT0g3vDCeeM1B38m939HNCDHWq4cOa0j8oPtlNxKaLa2T96e7uhcT1Ru
         poViYaXgMXYAwjvoerC137dBZKRbecr+O8VAZXFBVjfa0ubCJ2IUKh9l941s+GhCXbP1
         V1fk31PEcsozfToquTyQxD1eywH+vsH20x9nFk0/MaaqaZMAgKzjAvuDymC125mIk6z8
         G16GEk0GADkU2QaLtxvn3g8wJtyF3k426uDY17ahzVXIR/MkurVcnlERrp+tOTKHgsFw
         dkFWjFGbWSNceQeyduSxd5iqMhp2HiERvgs3Uh/B7C7B6U5ngdfR7zuXTDxpe6MfiRji
         EXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688774453; x=1691366453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxgbWUBnxExDB7kpFpIZUNOmBhUx/4DiPfGLMipANHo=;
        b=UQLroDm6qcMtvyZ+OJZCO+5fIup9wNuvXcJ2FvxNS1PfoxVxmOVVb5++vh3I4JrUYR
         xphAZ7FFfa7MkSBvnSWl6MiZkT+DDOnmwGk9VVUeyiPY/SlZzdkZWUumze/8atNQSSmk
         eHsLFtOv5cfVfGBNXn1AiE6Tl2YFaBQuCKAc1o3HEy+JLqG0y5+oUpl9RMSzZlTnlgHL
         DWMTUYbLkmlR/I2LolTWbU516SQxAJw4JFfoAzXLliKE5u1Ugf4WvFlymRzhC4YzLOID
         wHDGOjzmr5M1T43CqJqlbM62RONx3qw+4pUZhAFq5zA6VTSz/zUTQy6LhHkX7q1ES1kb
         FnjQ==
X-Gm-Message-State: ABy/qLa/cCacRo9d8fHbkj/fCwHvnN2mqVG5W00UUa9TzaxBEDRCaqvr
        TWt42EMGuXNnVBqe+m0iN9IA2Hq0PZ4=
X-Google-Smtp-Source: APBJJlGQldC0tnKsHDPFemqOHWjZ9KLTER4p9kqcxR96+RpG6rFQYASJUR/H0ADH80tQZYcoVRAidQ==
X-Received: by 2002:a05:6a21:999f:b0:12f:d812:6a0 with SMTP id ve31-20020a056a21999f00b0012fd81206a0mr7491452pzb.49.1688774452595;
        Fri, 07 Jul 2023 17:00:52 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:38de:2bd4:8f55:60cd])
        by smtp.gmail.com with ESMTPSA id w21-20020aa78595000000b0064f51ee5b90sm3383355pfn.62.2023.07.07.17.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 17:00:52 -0700 (PDT)
Date:   Fri, 7 Jul 2023 17:00:49 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Input: exc3000 - Support power supply regulators
Message-ID: <ZKinMbEZ9yujxdG3@google.com>
References: <20230707131042.10795-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.e9863e93-aebd-4f13-b014-08dab638277d@emailsignatures365.codetwo.com>
 <20230707131042.10795-2-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707131042.10795-2-mike.looijmans@topic.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 03:10:42PM +0200, Mike Looijmans wrote:
> Add power supply regulator support to the exc3000 devices.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 

Applied, thank you.

-- 
Dmitry
