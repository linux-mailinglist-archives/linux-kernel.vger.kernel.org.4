Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EAD5FD3F5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 06:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJMEth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 00:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiJMEte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 00:49:34 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55FF9EE896;
        Wed, 12 Oct 2022 21:49:33 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 7E3301E80D99;
        Thu, 13 Oct 2022 12:49:36 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9GiwSB4b5jgH; Thu, 13 Oct 2022 12:49:33 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id CD2F41E80D90;
        Thu, 13 Oct 2022 12:49:33 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     damien.lemoal@opensource.wdc.com
Cc:     jejb@linux.vnet.ibm.com, kunyu@nfschina.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com
Subject: Re: [PATCH 4.19] scsi: sd: Fix 'sdkp' in sd_first_printk
Date:   Thu, 13 Oct 2022 12:49:26 +0800
Message-Id: <20221013044927.278854-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <0e67aa4d-f66e-f392-5950-31b1c90c287b@opensource.wdc.com>
References: <0e67aa4d-f66e-f392-5950-31b1c90c287b@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is defined in the 4.19 kernel:

#define sd_printk(prefix, sdsk, fmt, a...)                              \
        (sdsk)->disk ?                                                  \
              sdev_prefix_printk(prefix, (sdsk)->device,                \
                                 (sdsk)->disk->disk_name, fmt, ##a) :   \
              sdev_printk(prefix, (sdsk)->device, fmt, ##a)

#define sd_first_printk(prefix, sdsk, fmt, a...)                        \
        do {                                                            \
                if ((sdkp)->first_scan)                                 \
                        sd_printk(prefix, sdsk, fmt, ##a);              \
        } while (0)



Most of the sdsk used in the macro definition has only one sdkp.


This is defined in the v6.0-rc7 kernel:

#define sd_printk(prefix, sdsk, fmt, a...)                              \
        (sdsk)->disk ?                                                  \
              sdev_prefix_printk(prefix, (sdsk)->device,                \
                                 (sdsk)->disk->disk_name, fmt, ##a) :   \
              sdev_printk(prefix, (sdsk)->device, fmt, ##a)

#define sd_first_printk(prefix, sdsk, fmt, a...)                        \
        do {                                                            \
                if ((sdsk)->first_scan)                                 \
                        sd_printk(prefix, sdsk, fmt, ##a);              \
        } while (0)

Use sdsk in macro definition.


I did report an error when compiling sd. o in the 4.19 kernel. It was modified to say that no more errors were reported in sdsk. Can I continue the 6.0-rc7 writing method here.

