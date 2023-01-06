Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C33C6602D5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbjAFPOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 10:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbjAFPOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:14:05 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94E877D34;
        Fri,  6 Jan 2023 07:14:03 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so3766459wms.0;
        Fri, 06 Jan 2023 07:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yst21N0uSYqEFSfuMC6izsJAwCQLkY9y90gu79pYeM4=;
        b=CZ5c1LoTctHQNBub/7AEZQNJqP9y+neA8rcDMogdCSI2nHueEiIiCWErGQeyfZ0660
         zgoZ6v3rBvPHYuF48BJIRbN8BAWkpnxkg34kQp+ZdgXlC+yINqA3fnJUj2TUoKRQilbE
         ZzH9quUoIpGoFVEsutX90VJ48I3AUArQhBfPOVPDCbQy62aRtR9gpUN+35LBBiilYUYh
         zXJglaZCMLawkgjr1o266kwfAZZNNjUUXs6MBLv0gmb8TzMIabyDVaECQs6Net7rti4D
         /9F32WMWeELSVER/kkRyQLplpHOES+jHQ9pMHsCzvB4Rzc6vKk3hRKG1Bbg6gCjQQs4W
         3asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yst21N0uSYqEFSfuMC6izsJAwCQLkY9y90gu79pYeM4=;
        b=d8QB5+i7gnmyQCsqV5OVdtzCgPEtc9/SWl+pYZ7ywfc5LtEL2oq5k/+Ahd8aC8V2QS
         z85gvoc9Z6hh5WMEn2q4+BGstmV14mCruijWtnA+BKIGomcyeg4oVp/3bGv1E9HExZIW
         c+RrgH11UAJjaP9cHJoGasnypAMWO4P/I2kKWb73P5B4hjJcRpPPpJTT0wKdlFLeuQUU
         rYMzDPk9MHVUhS4bEUPjEUy9pr37nObswlOJ2F1vhtEtOPmmY9mIuZ4E8rphjNZbmx5t
         fvIVKJwXOZfVDlM+Wdnt0tVZFCqnenzbHfJW3/6gIsyVZCo+RESaBNcCiYHs7NbYWRs1
         MQqg==
X-Gm-Message-State: AFqh2kqtcEBm9ozLCdVzzsNUrDXB+4GhyvKgNozGcA0QZ9EO0/CzC7c4
        nygr/wu47qe3Y4A4FOTTFse3HqWhaU6UfQ==
X-Google-Smtp-Source: AMrXdXsm3WjfA9H7piH5cTLWes10jjW4zKI1uvF4s5Prr2wLB8jXM59KAwFW+eNMt0A6yCUs5e066w==
X-Received: by 2002:a05:600c:348b:b0:3d2:2a72:2577 with SMTP id a11-20020a05600c348b00b003d22a722577mr38623383wmq.27.1673018041983;
        Fri, 06 Jan 2023 07:14:01 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u13-20020a05600c19cd00b003c6f1732f65sm7264982wmq.38.2023.01.06.07.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 07:14:01 -0800 (PST)
Date:   Fri, 6 Jan 2023 18:13:58 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     outreachy-kernel@googlegroups.com
Subject: calling iounmap while holding a spinlock (preempt disabled)
Message-ID: <Y7g6tkauv8eV3ZBm@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch complains correctly that it is a bug to call iounmap while
holding a spin_lock (or other actions which disable preemption).

However there are too many bugs for me to look at them so I'm just
going to forward the list here and whoever wants to can fix them as
a kind of newbie project.

The Smatch warnings look like:

arch/x86/mm/ioremap.c:471 iounmap() warn: sleeping in atomic context
arch/x86/mm/ioremap.c:494 iounmap() warn: sleeping in atomic context

Which means that the iounmap() function sleeps.  Then we run
`smatch/smatch_data/db/smdb.py preempt iounmap` to get the list of
callers which disable preemption.

The raw output is below.  Basically every "disables preempt" is a bug.
In the first example, tsi148_master_set() calls spin_lock(&image->lock),
then it calls tsi148_alloc_resource() which calls iounmap().  Clear bug.
However it's not clear how to fix it necessarily.

regards,
dan carpenter

tsi148_master_set() <- disables preempt
-> tsi148_alloc_resource()
hfc_remove_pci() <- disables preempt
-> release_card()
   -> release_io_hfcmulti()
pcc_get_freq() <- disables preempt
pcc_cpufreq_target() <- disables preempt
-> pcc_cmd()
   -> acpi_read()
      -> acpi_hw_read()
ghes_poll_func() <- disables preempt
ghes_irq_func() <- disables preempt
ghes_notify_hed() <- disables preempt
ghes_probe() <- disables preempt
-> ghes_proc()
ghes_notify_nmi() <- disables preempt
-> ghes_in_nmi_spool_from_list()
ghes_sdei_normal_callback() <- disables preempt
ghes_sdei_critical_callback() <- disables preempt
-> __ghes_sdei_callback()
   -> ghes_in_nmi_queue_one_entry()
      -> __ghes_panic()
ghes_in_nmi_queue_one_entry() <duplicate>
         -> ghes_clear_estatus()
            -> ghes_ack_error()
ghes_proc() <duplicate>
-> ghes_read_estatus()
ghes_in_nmi_queue_one_entry() <duplicate>
   -> __ghes_peek_estatus()
               -> apei_read()
                  -> acpi_os_read_memory()
pcc_cmd() <duplicate>
-> acpi_write()
   -> acpi_hw_write()
ghes_ack_error() <duplicate>
-> apei_write()
      -> acpi_os_write_memory()
                     -> iounmap()


