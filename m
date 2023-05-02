Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27536F42D8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 13:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbjEBLbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 07:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbjEBLbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 07:31:50 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F0D59FE
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 04:31:27 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f1958d3a53so36109765e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 04:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683027085; x=1685619085;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vgouLHt67B3v2ehwGE/0MEW+U6EiOv+zR81KVmek+co=;
        b=lsS3QOHHI3E7EQ6XOHLd2dr9r+x41qiXFeUDutI0eZrl9ec9OYaLXPBP0jBP1lzMb2
         fnaQyVeh80DeHjgDURvZfOxjju+9NM+PoGMbWXWNFCo54d6ws0ZmUOrh8GgWjKOsR3CY
         KB1mLeRrMVh8c8UvpP1NzMOD4rsRHu/i9RfeSbOlcQq1MRZn43PlnAVeTqRJ6htFo51a
         WBRLZvVxdq+fyxfqY2D/vq+Ly52K7cm8aiA9+1GzzShfxq18qLBknKNYFyEnbMijgSmj
         uz9+K4IxgDrFV8BUAo2OaxQ0EkJpRXGYrSp+TKsMBApgyUYHp5K3T50L+zKW3yWy2CFk
         bP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683027085; x=1685619085;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vgouLHt67B3v2ehwGE/0MEW+U6EiOv+zR81KVmek+co=;
        b=Ubs9vTLalc/4yyc6uuNpwcmujl0IyO80o2N45NCb2C3SCjbjArt99ExY6hpL+LBh/W
         u7GJ8hiTuwdX1rOh0R0SM78fQb0npuLpA7VDxJk6X7jfs4bU4y/ZHlC88ZV+FTGQwY9s
         dCtWH31v/RS/syBXLVvPeJQDbuNatnmCKDK0xOsi6pehIiJXylLmI4eU7urC0XHGQPUK
         +B0E+DZzp679xVSVnbRvi8rMPeBP1vdhe75EIi+tP0cTjDbI5HESBGY9Lk8OgVFPeIld
         pznwlx3EGR0KhDeB/u93oV1c2nFviURMKjphrvQL6dzZV5Subr5Pm1N/3sqr/JjUAFCy
         dHYQ==
X-Gm-Message-State: AC+VfDxlRZRV9KQUrwSDgU8u+j8gaJl7urSuMdoqBNoiGxpPx+VoNIsG
        a9/uqm8m0OyYoTzbJgQar0Gbwg==
X-Google-Smtp-Source: ACHHUZ4nyqX2wSqcF7T9axJmiJaKlnqKXlJo9uefp3OfJHIHYIONpy2H+9kUGbvbxECAgDnKXB+cMA==
X-Received: by 2002:a5d:49c6:0:b0:306:2c01:4029 with SMTP id t6-20020a5d49c6000000b003062c014029mr4410508wrs.5.1683027085613;
        Tue, 02 May 2023 04:31:25 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m18-20020adffa12000000b003047297a5e8sm24006691wrr.54.2023.05.02.04.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 04:31:24 -0700 (PDT)
Date:   Tue, 2 May 2023 14:31:20 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Steve French <stfrench@microsoft.com>
Subject: fs/ksmbd/smb_common.c:350 smb1_allocate_rsp_buf() warn: Please
 consider using kzalloc instead of kmalloc
Message-ID: <670b3581-db50-4ba4-ad49-73c1e7006ad1@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d06f5a3f7140921ada47d49574ae6fa4de5e2a89
commit: dc8289f912387c3bcfbc5d2db29c8947fa207c11 ksmbd: fix slab-out-of-bounds in init_smb2_rsp_hdr
config: openrisc-randconfig-m041-20230423 (https://download.01.org/0day-ci/archive/20230428/202304281001.oskkuJo0-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202304281001.oskkuJo0-lkp@intel.com/

smatch warnings:
fs/ksmbd/smb_common.c:350 smb1_allocate_rsp_buf() warn: Please consider using kzalloc instead of kmalloc

vim +350 fs/ksmbd/smb_common.c

dc8289f912387c Namjae Jeon 2023-04-01  348  static int smb1_allocate_rsp_buf(struct ksmbd_work *work)
dc8289f912387c Namjae Jeon 2023-04-01  349  {
dc8289f912387c Namjae Jeon 2023-04-01 @350  	work->response_buf = kmalloc(MAX_CIFS_SMALL_BUFFER_SIZE,
dc8289f912387c Namjae Jeon 2023-04-01  351  			GFP_KERNEL | __GFP_ZERO);

Someone else wrote this Smatch check to encourage people to use kzalloc()
instead of __GFP_ZERO.  I try stay out of style debates.  :P

dc8289f912387c Namjae Jeon 2023-04-01  352  	work->response_sz = MAX_CIFS_SMALL_BUFFER_SIZE;
dc8289f912387c Namjae Jeon 2023-04-01  353  
dc8289f912387c Namjae Jeon 2023-04-01  354  	if (!work->response_buf) {
dc8289f912387c Namjae Jeon 2023-04-01  355  		pr_err("Failed to allocate %u bytes buffer\n",
dc8289f912387c Namjae Jeon 2023-04-01  356  				MAX_CIFS_SMALL_BUFFER_SIZE);
dc8289f912387c Namjae Jeon 2023-04-01  357  		return -ENOMEM;
dc8289f912387c Namjae Jeon 2023-04-01  358  	}
dc8289f912387c Namjae Jeon 2023-04-01  359  
dc8289f912387c Namjae Jeon 2023-04-01  360  	return 0;
dc8289f912387c Namjae Jeon 2023-04-01  361  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

