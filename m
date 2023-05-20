Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF3470A679
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 10:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjETIqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 04:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjETIqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 04:46:43 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244D2E4C;
        Sat, 20 May 2023 01:46:42 -0700 (PDT)
Received: from mta-01.yadro.com (localhost.localdomain [127.0.0.1])
        by mta-01.yadro.com (Proxmox) with ESMTP id EA90A342388;
        Sat, 20 May 2023 11:46:38 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; h=cc
        :cc:content-type:content-type:date:from:from:in-reply-to
        :message-id:mime-version:references:reply-to:subject:subject:to
        :to; s=mta-01; bh=fkECQlR9rLVSIN/F4sez472vipRURgcRLDvkhrvB4T4=; b=
        UuqNXrKV3xui2busCIEj3xhEwlcchtH1fH7JTOC6FVjO/JUncnVZMJohdHPvWDTA
        rJmfnjIReSzjodfrjnujIdrNcrYCXA3UyJLlfKBJl9xMTp5PXoROZpMhYEQ+KoQt
        Tcu07rwfJmm/Ene3/Jm5hsAL+9pASnKGyffQSGzlpDY=
Received: from T-EXCH-08.corp.yadro.com (unknown [172.17.10.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Proxmox) with ESMTPS id E00A6342036;
        Sat, 20 May 2023 11:46:38 +0300 (MSK)
Received: from yadro.com (10.178.114.42) by T-EXCH-08.corp.yadro.com
 (172.17.11.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Sat, 20 May
 2023 11:46:38 +0300
Date:   Sat, 20 May 2023 11:46:00 +0300
From:   Dmitry Bogdanov <d.bogdanov@yadro.com>
To:     Grzegorz Uriasz <gorbak25@gmail.com>
CC:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <target-devel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dutkahugo@gmail.com>
Subject: Re: [PATCH] scsi: target: Fix data corruption under concurrent
 target configuration
Message-ID: <20230520084600.GC20571@yadro.com>
References: <5f637569-36af-a8d0-e378-b27a63f08501@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5f637569-36af-a8d0-e378-b27a63f08501@gmail.com>
X-Originating-IP: [10.178.114.42]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grzegorz,

On Sat, May 20, 2023 at 02:26:14AM +0200, Grzegorz Uriasz wrote:
> 
> This fixes data corruptions arising from concurrent enabling of a target
> devices. When multiple enable calls are made concurrently then it is
> possible for the target device to be set up twice which results in a
> kernel BUG.
> Introduces a per target device mutex for serializing enable requests.

Device enable call is already secured by configfs per-file mutex. That
is actually per device. So Enable procedures are already not executed
simulteniously.

Look like you wrongly identified the root cause of double list_add.


If you have an evidence that dev->dev_flags could have no DF_CONFIGURED
bit, then it meeans that it (dev_flags) is raced in other
configuration actions (udev_path, vpd_unit_serial, alias).
Bits in dev->dev_flags are written not atomically and if you writes to
enable, alias, udev_path,unit_serial files simulteniously, then some
bits could be lost.

IHMO the best solution is to make dev_flags changes be atomical.

BR,
 Dmitry

