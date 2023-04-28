Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139576F0FEC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 03:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjD1BPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 21:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjD1BPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 21:15:31 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD3026BA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 18:15:29 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63d32d21f95so1903774b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 18:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682644529; x=1685236529;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdAMIiYmqSQz1GbWDTNHZpSZR6NUQD27x8IVMPn6Rlk=;
        b=sa+18BQfIXdO34J2oBZ5fSNZDw2+/e2xdxFJ6iVqaxb1QxklxwVdWMI6yAs6m/RXcG
         hfCvJZzISTfabi+tC/OLXZyJxmQaWFrefjil/FlgPAPMdVKcCqbLhRn+h8eIWvXlS8iJ
         /I/b9TjLaNJB9EVoYkWPxoRdY4h6oGKU7HwGje2SXoKok/o3pDz+eEsBMclToXbyGCZG
         mFWMsHrQiSG51MpgLF6Vm4jULI7sg02cU6J3SmaHgwSwUU0fEn/C0JuSqoGjF2+SJ95c
         LdX+qb1fRPWe/Sy/EGOigwFdj+uTAUfnCPj7I+qWoFvYbU7FOqL4/hDVkR0bpJetnn2J
         DT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682644529; x=1685236529;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdAMIiYmqSQz1GbWDTNHZpSZR6NUQD27x8IVMPn6Rlk=;
        b=Hb2Y5HjYGkWGqqhzXLpgTwUMU7xMFwJ+NAY9aIJb3ozm2QJQlTNEWyPJa288DRf6Cm
         3GGjeAiDyRuwmMxTs2BX+69iQV35+gwrKD+jZL/4yLL0Kft9F04f4TlIBACl39tjP8T5
         K2Bf/7AeGvTc9oVPtVymLd1VGf6if3qi3sQh1Net+WAVqrbSP8jOqYCWRxHtB/z+jLGm
         stdPGlpa4kY/iGjhePD3WlN8L/tqIuWxQtqtkzgHF1JdWJ6jNz2hP2YqLnWMjua8XiSw
         ARJaPrfEqy3S+fFwXuC7+aKhdvKPK8e9tSSj5h5JATyCOQEx/ShWPhYtfvo4J10xev3i
         wBDw==
X-Gm-Message-State: AC+VfDz5zat1AkPUUoKGscaVLoDQYz8qj3icKTRg6GDZH+RS5r0iYrEk
        5RScepnPaOVEE1+qKhG0uFd/BA==
X-Google-Smtp-Source: ACHHUZ7X+opn2Ubw1AwkQMzsSBun7dBZmvM343LIKmA46Kxphf9kLViwUZGrEMzvdhctRRtKV/mFeQ==
X-Received: by 2002:a05:6a20:7f99:b0:f6:d60d:dbc8 with SMTP id d25-20020a056a207f9900b000f6d60ddbc8mr3325695pzj.2.1682644529298;
        Thu, 27 Apr 2023 18:15:29 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id om12-20020a17090b3a8c00b002405d3bbe42sm13893828pjb.0.2023.04.27.18.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 18:15:28 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, Eric Blake <eblake@redhat.com>
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230410180611.1051618-1-eblake@redhat.com>
References: <20230410180611.1051618-1-eblake@redhat.com>
Subject: Re: [PATCH v3 0/4] nbd: s/handle/cookie/
Message-Id: <168264452819.133910.16210912670607469975.b4-ty@kernel.dk>
Date:   Thu, 27 Apr 2023 19:15:28 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Apr 2023 13:06:07 -0500, Eric Blake wrote:
> v2 was here: https://lkml.org/lkml/2023/3/17/1107
> since then:
> - squash patch 2/5 and 3/5 into 3/4 [Ming]
> - add Josef's R-b
> - tweak commit messages to match commits in userspace NBD (code itself
>   is unchanged, modulo the patch squash)
> 
> [...]

Applied, thanks!

[1/4] uapi nbd: improve doc links to userspace spec
      commit: daf376a366fd2d469d66ab83dfdc074777462bab
[2/4] uapi nbd: add cookie alias to handle
      commit: 2686eb845da7762ee98b17e578b0c081aafb77b9
[3/4] block nbd: use req.cookie instead of req.handle
      commit: bd9e9916c32fd4b4fb4e879e05bd1568ee02ec93
[4/4] docs nbd: userspace NBD now favors github over sourceforge
      commit: 952aa344bf4305ab6fa0d9962ef8c2caa2afef4c

Best regards,
-- 
Jens Axboe



