Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37549745E77
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjGCOXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjGCOXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:23:40 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704E3E54;
        Mon,  3 Jul 2023 07:23:39 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fba8f2197bso3814284e87.3;
        Mon, 03 Jul 2023 07:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688394218; x=1690986218;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ma1KyTozt79WQFhFhjXGW+QNtFHS9FsRimX5pJ9eb2c=;
        b=XsaWtZ1Nvob2QnhpQ+rGPXskrrUnIUfb8AfDMGrGMXcP3ipTsMBZwIWWcsQpkQwsB7
         VQeAXSX0cLA73q5xLjoNs9ZF8PQRPT6VMDZE1dBpTm8nQVBp0XeQfPEK6sKv6Cljd787
         b/+QlojCMnXwPnpdRTmdhsMT9XBsUyaDhqUnWBObP6buoCQECb7W91hw4wkawJdemlHf
         gmyTiIeDS3hdGtf7PLbd4hdcNVjlrvlFvtBU6s1N+sj+o5GiHYl5Lq3BQoJ5e5DuTXax
         H5fmhWdNPuBgx64XbbMRXtoDarKJDzMwJi3fXH8i3ZdP4H5I8IqxDz+Yi2kp2wmNe6WU
         6QyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688394218; x=1690986218;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ma1KyTozt79WQFhFhjXGW+QNtFHS9FsRimX5pJ9eb2c=;
        b=isAVLrshGDnrpM6TCLquSbodCPpe8UfJsifwcvpN25wLX7+cONi9sKv3k6e7aIkt6P
         ECzUumXqffxifP8VagcFapFBFQGDWTwXe695T5WihEdbUVu9rv0TGELfe9G7wATqT4k/
         ke75dEif/H1ZFiBl1d6VF8ykMdAz80DxeeJQJqTpMIYGcXVsrHw/YBEMGcfI+3GyQjZp
         79bQOh66xIsIoCBdbfaTi7vdhitvcIDD7f12QgIkWhc6X++CV6JFqXt4CxkSxiN9m06P
         3e1GFLQyyhHOLA5C/ZKjrDklAHZg4QUXmQ4HDgm9CHqZ7q3h62PeqaG+bWm0qz8+5Qno
         Fegw==
X-Gm-Message-State: ABy/qLZ6MdaIVTcoNiR+QB3P8sY6WKEoHWnSij/nnxRxGzfFFpmFzIQG
        9V7pX2+hERT4R5ja1Jhp3TE=
X-Google-Smtp-Source: APBJJlH+pIwmjwOtnM94dmF/0nZ2RXR9s92STPPhPgs1uUFf5jUOOFZrrYogPdzH5ER+Pxr8NAmXyQ==
X-Received: by 2002:a05:6512:281a:b0:4f8:742f:3bed with SMTP id cf26-20020a056512281a00b004f8742f3bedmr7730273lfb.37.1688394217383;
        Mon, 03 Jul 2023 07:23:37 -0700 (PDT)
Received: from debian ([89.238.191.199])
        by smtp.gmail.com with ESMTPSA id p20-20020a1c7414000000b003fa973e6612sm22049004wmc.44.2023.07.03.07.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 07:23:37 -0700 (PDT)
Date:   Mon, 3 Jul 2023 16:23:18 +0200
From:   Richard Gobert <richardbgobert@gmail.com>
To:     Gal Pressman <gal@nvidia.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, aleksander.lobakin@intel.com,
        lixiaoyan@google.com, lucien.xin@gmail.com, alexanderduyck@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] gro: decrease size of CB
Message-ID: <20230703142314.GA27131@debian>
References: <20230601160924.GA9194@debian>
 <20230601161407.GA9253@debian>
 <f83d79d6-f8d7-a229-941a-7d7427975160@nvidia.com>
 <20230629123559.GA12573@debian>
 <431d8445-9593-73df-d431-d5e76c9085cf@nvidia.com>
 <20230630153923.GA18237@debian>
 <fdc1d609-5604-f372-6e64-1ea971fabe84@nvidia.com>
 <50181937-19ea-ccca-057c-eb6931f4b2da@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50181937-19ea-ccca-057c-eb6931f4b2da@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for replying.
I will check it out and update once there is something new.
