Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893845BEAC5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiITQGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiITQGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:06:12 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DB23F1EC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:06:09 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so11267404pjq.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=mVXjEkchDteCE1zCDTUzpbpt8ACeKtrTbNbxuuk9ZdA=;
        b=WhArmtdqs/KKDWTWMCosIdRxKr5Uet/gXZ+ddafXZpICoDfqgBCpm+m0BrBuw5VioO
         N01TiT3dRBp4xqgudzkm/sAl1qlY6gQRp0RC6rRz6Go7V8X64Hkj64kZuiRacglKXcCE
         L0xB0mvUGlbtRw3Byz1SGuCNldmz/jpLsQRM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=mVXjEkchDteCE1zCDTUzpbpt8ACeKtrTbNbxuuk9ZdA=;
        b=Mo8UwfSMeYgziDHs+Gz9KQSVnvUr3d7KNnXVRGKargc14xLbhNss808hlCdlGg5w7q
         XRyHNb35VD/RzSTYpBsHy+libb631dnuHV25LfHemIF00dFDa3KgXrCw4ofDxS3e4/A4
         N+H3FAW6AbZgjnLqkTWIp75yw+upA0nt8FCsu4IBuu/qDVjy8yCeoeY+omi/XtkAjT2Z
         S1qh4lvzwXL3Avi4aU6Ki2EeYOL9Iv5I6d53saDRn4Yw7nJyM/W5NPa55cxkZ4l/Ib/l
         vtQgW1br/0powZTTlHfL2BrL3bbQtLKWS0x6zPdYKXnSdx1Za9iKV+R6sfbF+diqQ9+Y
         y2Ag==
X-Gm-Message-State: ACrzQf3tsUStqt8upbhiPPvv+nYLDMQhP+wqvn1V4v177PdgcTLi4Knr
        r2RAKR6vqsNjiwFL6EtwcX8eHA==
X-Google-Smtp-Source: AMsMyM4CDISk3X5hd2+0a+iB0Ji58ldPnFUwavVGxhVfv8jmCnDVTEmhu9onCz743+5jWuUglxommQ==
X-Received: by 2002:a17:903:32c4:b0:178:5206:b396 with SMTP id i4-20020a17090332c400b001785206b396mr365485plr.99.1663689968516;
        Tue, 20 Sep 2022 09:06:08 -0700 (PDT)
Received: from medusa.lab.kspace.sh (c-98-207-191-243.hsd1.ca.comcast.net. [98.207.191.243])
        by smtp.googlemail.com with ESMTPSA id l2-20020a170902f68200b001730a1af0fbsm102688plg.23.2022.09.20.09.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 09:06:07 -0700 (PDT)
Date:   Tue, 20 Sep 2022 09:06:06 -0700
From:   Mohamed Khalfella <mkhalfella@purestorage.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     stable@vger.kernel.org, Eric Badger <ebadger@purestorage.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Tao Chiu <taochiu@synology.com>,
        Leon Chien <leonchien@synology.com>,
        Cody Wong <codywong@synology.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme-pci: Make sure to ring doorbell when last request
 is short-circuited
Message-ID: <20220920160606.GB3444537@medusa>
References: <20220918054816.936669-1-mkhalfella@purestorage.com>
 <YyioTUV/Td+yf0Z6@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyioTUV/Td+yf0Z6@kbusch-mbp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-19 11:35:09 -0600, Keith Busch wrote:
> > Fixes: d4060d2be1132 ("nvme-pci: fix controller reset hang when racing with nvme_timeout")
> 
> I revisted that commit, and it doesn't sound correct. Specifically this part:
> 
>     5) reset_work() continues to setup_io_queues() as it observes no error
>        in init_identify(). However, the admin queue has already been
>        quiesced in dev_disable(). Thus, any following commands would be
>        blocked forever in blk_execute_rq().
> 
> When a timeout occurs in the CONNECTING state, the timeout handler unquiesces
> the queue specifically to flush out any blocked requests. Is that commit really
> necessary? I'd rather just revert it to save the extra per-IO checks if not.

I can not speak with certainty whether 4060d2be1132 need to be reverted or not.
I will need to carefully inspect reset code path and do more experiments. If this
commit gets reverted we still need to add `nvme_commit_rqs` to `nvme_mq_admin_ops`.
