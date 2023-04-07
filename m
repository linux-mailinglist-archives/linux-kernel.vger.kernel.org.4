Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251036DAA8D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240451AbjDGJDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240322AbjDGJDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:03:44 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC6365A4
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 02:03:43 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j11so2121104wrd.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 02:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680858222; x=1683450222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YYSSCxyGFuJJQJt2T6qHhv/TJbUeBnXIOLjJOI/JHLw=;
        b=XuVKriI+uWrCAOurME6hOvGpx/DI16o+K0O7nEvu+V8RF5YeadKyf4rGsNI1NyuJml
         Ud/KwjjZfR27kIwMLxLOu3jdKUH0pVoN4GozKp8SRV7Tm/0hNVb2grK5NDb/hWQclRnr
         f6IoNwiLrjMnAE4u3y6bybd4Jme42q7s97nmu0E6mmyyA51HtefSIIMr4fZfIpyewWI8
         6RldVBJT9OXjy0vGWJacCDJhozTbq8sv8o4k2pnTIYb8nlaTh5al6gDVyQF1hbOSlh0T
         /z51Ned5r/yZFaA9Fo53S/g/8ItpytT83V2cu1YhAACy8+MgwMkiMUpz1l3wv3RFdcdZ
         wOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680858222; x=1683450222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYSSCxyGFuJJQJt2T6qHhv/TJbUeBnXIOLjJOI/JHLw=;
        b=V0y6BETkwRROsAkAGfSvgAq+sUzccXZzScTIL8TmG7oTo6Zj7nEOLPXNYVocQ9ADv5
         fF0yo2AuLLPJddhvpRDHQ85zfRRc7ceqhQdWng4GsyBt65+WLF01CVAjNk3iIloC+AAa
         1dFDz8GaxJOecJd7IgHx8UyslTsSMvhtWjoPFG30pBL6V0U5FgBOryl8hC01RtABzgY6
         fgeuMHmvxRJriD6FBgw+Z7dZmOonQmjBPhNMbtFKAJFdHxBhj+dNV/wM5rONCsaCTVND
         s+9FQZCztn48eBXdhwmKIIDPOgGu5V6ITHvFDmn/lknqFvgFTwyDGgy0H1bOu7I/3y/8
         J8sQ==
X-Gm-Message-State: AAQBX9eORbx0UBwmgba7Cq1she2PQFoY94Hip2T5GZEVjWKs8mcps58Q
        F0MQ1aH2Oi3LJdWGyuokxUM=
X-Google-Smtp-Source: AKy350atgTsGKVEldHhmS0YK8dxjm/y9KV/59TRgiFG8NWxJD4nG7UgVJ1XjN5FvQMpwAIVzBiqWxQ==
X-Received: by 2002:adf:f805:0:b0:2e6:271:32ea with SMTP id s5-20020adff805000000b002e6027132eamr1019690wrp.30.1680858221737;
        Fri, 07 Apr 2023 02:03:41 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c3-20020adffb43000000b002de99432fc8sm3993945wrs.49.2023.04.07.02.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 02:03:41 -0700 (PDT)
Date:   Fri, 7 Apr 2023 12:03:35 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Weight <russell.h.weight@intel.com>,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v3 1/2] test_firmware: Fix some racing conditions in
 test_fw_config locking.
Message-ID: <c1eda760-2ed1-4f42-b8bb-7e380e1adb3e@kili.mountain>
References: <20230406015315.31505-1-mirsad.todorovac@alu.unizg.hr>
 <eb117a50-79ad-4f5a-8ad9-73247107469e@kili.mountain>
 <1f07fd79-b7db-9bd5-f281-8ba1ca71e195@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f07fd79-b7db-9bd5-f281-8ba1ca71e195@alu.unizg.hr>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 10:24:24AM +0200, Mirsad Goran Todorovac wrote:
> 
> Hi Mr. Carpenter,
> 
> Thank you for your review.
> 
> I will proceed according to your guidelines and issue the next version of the
> patch set.
> 
> But I cannot promise it will be before the holidays - I do not want to make
> the gods angry either ;-)
> 

There is never a rush.

> I cannot promise to try smart macros or inline functions with smart function
> parameters just yet.
> 

Don't worry about that.  It just seemed like you were working towards
a more general purpose infrastructure.  It's just a clean up.

> I would consider the real success if I hunt down the remaining leak and races
> in this driver. Despite being considered a less important one.
> 
> As you have previously asserted, it is not a real security issue with a CVE,
> however, for completeness sake I would like to see these problems fixed.

That's great.  If you get bored and feel like giving up then just send
PATCH 2/2 by itself because that one could be merged as is.

regards,
dan carpenter

