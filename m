Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858247189E2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 21:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjEaTKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 15:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjEaTKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 15:10:30 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C01F135;
        Wed, 31 May 2023 12:10:17 -0700 (PDT)
Received: from thinkpad-p16sg1.corp.microsoft.com (unknown [167.220.83.99])
        by linux.microsoft.com (Postfix) with ESMTPSA id 69D6C20FC460;
        Wed, 31 May 2023 12:10:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 69D6C20FC460
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1685560216;
        bh=9rE+SRTAB7sC3g3Xr1k+PcNR3GwWZig7+s8JNU7XI3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fh3aU97ZtLl3PvKiFD9yWeRQQQOiG5RXMOq9r1TDHFc3KdhBh+vWqhIRBW2UZ0Oo3
         26z1yMRdq/L6jlE6v08iZ4HaVdcy8VmbNqSb8d0DoJylWTO2bmGXwDFxEODsbuuoO7
         7rQ9wWuH8I00/AeQiO+TQaKPHibhShpFNwzPMVfk=
From:   Shyam Saini <shyamsaini@linux.microsoft.com>
To:     alex.bennee@linaro.org
Cc:     code@tyhicks.com, Matti.Moell@opensynergy.com, arnd@linaro.org,
        bing.zhu@intel.com, hmo@opensynergy.com,
        ilias.apalodimas@linaro.org, joakim.bech@linaro.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-scsi@vger.kernel.org, maxim.uvarov@linaro.org,
        ruchika.gupta@linaro.org, tomas.winkler@intel.com,
        ulf.hansson@linaro.org, yang.huang@intel.com,
        sumit.garg@linaro.org, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org
Subject: [PATCH  v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
Date:   Wed, 31 May 2023 12:10:07 -0700
Message-Id: <20230531191007.13460-1-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220405093759.1126835-1-alex.bennee@linaro.org>
References: <20220405093759.1126835-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

[ Resending, Sorry for the noise ]
 
Are you still working on it or planning to resubmit it ?

[1] The current optee tee kernel driver implementation doesn't work when IMA is used with optee implemented ftpm.

The ftpm has dependency on tee-supplicant which comes once the user space is up and running and IMA attestation happens at boot time and it requires to extend ftpm PCRs. 

But IMA can't use PCRs if ftpm use secure emmc RPMB partition. As optee can only access RPMB via tee-supplicant(user space). So, there should be a fast path to allow optee os to access the RPMB parititon without waiting for user-space tee supplicant.

To achieve this fast path linux optee driver and mmc driver needs some work and finally it will need RPMB driver which you posted.
 
Please let me know what's your plan on this.
 
[1] https://optee.readthedocs.io/en/latest/architecture/secure_storage.html

Best Regards,
Shyam
