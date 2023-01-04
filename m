Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F32C65DBCB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 19:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239754AbjADSFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 13:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbjADSFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 13:05:16 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06AA1AA01
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 10:05:13 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id g20so18411185iob.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 10:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwbSRErGI+M+kxIjiNvET71nV5klg9jfFeBjal8e880=;
        b=RsyncF9aIG927BmS+icDdcL5LIowTNpFEhbPJ5WkHLbZJWCFl/U/gFKQqUPKFXGajz
         U2ThHcuqcr/NWVgmuh62RSKba0GAC4p00gClmHL0CaV6Cxk/vtEDcbh88KjJefpuPE8A
         aG998LvTAb/8zGvypWeoJYLdMBtx95w5WxIwvT6gFJoSKG1lQqB1K5C3gY0fPM6o5mGK
         hrDYWci9vx3GoAVdl9Z6FD6iyI55V0kmhcqzixSgBXqJb2+f0WZBLbkE+Nrb0LLveNIh
         d3qnbKEB4eyshd2dawwsVhIy1Jc+IBJ8zqW5wOh8/1duAIkBQP5WS3WFTvGaodY8hiCq
         PAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwbSRErGI+M+kxIjiNvET71nV5klg9jfFeBjal8e880=;
        b=Wm/Byr/sZ3XDCmK1fFNjGTtSSuEdCMPImzX4LQaEzXrzy8PwIOLos7aMFxHL3oAfAM
         3pjqEKPouaLoiKVaiGsOt7aF6JCpch1hTsm4WL3pIjjyrlJW6Gghn8rvB/BsBbw3jzfl
         uZCkSJh9guzK9JVzu2qDw2zg2Gjj0YKeGTp7EWfycU1ILtwf04maxW9FUYkPKc+YWGqH
         iYMJCN4LRNPrIIV0vHyB++EY90vUm8P1MsqhL0wpvxWYKI5lR5eWuxDR0MuEcm0LLWp1
         DQI4MsCary1EwuReJAlF7VtLUouFZ4DbjoSJDB0a4225xnbLGFGl9us73GQUNF8D3n5B
         SoJA==
X-Gm-Message-State: AFqh2krg0f3eY3SIBaVjiup7GiLBKi3gRlQhLgwImo7vW/swnXwmnKNi
        wfhC96VsjLKVoDRZfHESTatquA==
X-Google-Smtp-Source: AMrXdXtZgRTw0Rd+lWWQFY6awnxtC+Ar0uDv/+rCvqrsUk26zYgQBzwslu+rRnkVVwLOdLilv7Awhw==
X-Received: by 2002:a6b:e812:0:b0:6f3:fed4:aa36 with SMTP id f18-20020a6be812000000b006f3fed4aa36mr5132225ioh.1.1672855513121;
        Wed, 04 Jan 2023 10:05:13 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id h13-20020a056602130d00b006cab79c4214sm6904465iov.46.2023.01.04.10.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 10:05:12 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, damien.lemoal@opensource.wdc.com
In-Reply-To: <20230103145503.71712-1-paolo.valente@linaro.org>
References: <20230103145503.71712-1-paolo.valente@linaro.org>
Subject: Re: [PATCH V13 REBASED 0/8] block, bfq: extend bfq to support
 multi-actuator drives
Message-Id: <167285551197.71557.16292371729864205895.b4-ty@kernel.dk>
Date:   Wed, 04 Jan 2023 11:05:11 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12-dev-7ab1d
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 03 Jan 2023 15:54:55 +0100, Paolo Valente wrote:
> rebased V13 [2].
> 
> Here is the whole description of this patch series again.  This
> extension addresses the following issue. Single-LUN multi-actuator
> SCSI drives, as well as all multi-actuator SATA drives appear as a
> single device to the I/O subsystem [1].  Yet they address commands to
> different actuators internally, as a function of Logical Block
> Addressing (LBAs). A given sector is reachable by only one of the
> actuators. For example, Seagate’s Serial Advanced Technology
> Attachment (SATA) version contains two actuators and maps the lower
> half of the SATA LBA space to the lower actuator and the upper half to
> the upper actuator.
> 
> [...]

Applied, thanks!

[1/8] block, bfq: split sync bfq_queues on a per-actuator basis
      commit: abc653033297fb39c097f9e18cc4ab42a5c00a23
[2/8] block, bfq: forbid stable merging of queues associated with different actuators
      commit: d591f14a59ed700caff6db734ecf558387d38f35
[3/8] block, bfq: move io_cq-persistent bfqq data into a dedicated struct
      commit: d85fed150b4efadf01ea3d12ba78285f6720f583
[4/8] block, bfq: turn bfqq_data into an array in bfq_io_cq
      commit: 7cf744815a3cd94591b0227f3c63f533f3402a47
[5/8] block, bfq: split also async bfq_queues on a per-actuator basis
      commit: 8249909fe789d7dc50f6749bbdf440d69ac46ac1
[6/8] block, bfq: retrieve independent access ranges from request queue
      commit: b3d9aece342834ef3840b55a99a11dc82b1f96cc
[7/8] block, bfq: inject I/O to underutilized actuators
      commit: 3f40467eb5ec1e4f383daff7f93c7494e7881fee
[8/8] block, bfq: balance I/O injection among underutilized actuators
      commit: dd9b66eb9ed5c0e58098c336cb8e6329590564be

Best regards,
-- 
Jens Axboe


