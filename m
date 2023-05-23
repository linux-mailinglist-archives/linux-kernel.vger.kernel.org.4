Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5052570D9C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 12:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbjEWKCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 06:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236316AbjEWKCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 06:02:47 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610BF132
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:02:42 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5A9CE1BF208;
        Tue, 23 May 2023 10:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684836161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=a2X2o1fmaa1cehsLX03P7UvDuU2iv0Z7n1zQF/eTIGQ=;
        b=m59422MPFP2mjMcKRTMROL/G25M+mB1uroXOPfLlxSTgXaI+K3bUNuhIRUKWNafaEnu+th
        iwambSIpmzsCni5GOG917nhaInGj4Wg+sQCStYhLbkcdbCK36xJfunFiKkksJd1qOLjFnG
        fVM416MPpR8F8mdqxkvVCuQv8dgI+AXonVEVItI+QEcBAZsVKsuEVEYYA0lGKcS3hzyC7D
        dufyUNwTxYFNPxcaKWwVfIrFfDY6KPG+z0vHgpzjj62amvD7vWVrjsSlsdaCGd7s9v7p1z
        btHlrgEnn7ZDoaMQudSJkkS9+OfE+gR50MsR9vzkTyneKG0Zxh5Iar2V+7e+Ww==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/2] NVMEM cells in sysfs
Date:   Tue, 23 May 2023 12:02:37 +0200
Message-Id: <20230523100239.307574-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

As part of a previous effort, support for dynamic NVMEM layouts was
brought into mainline, helping a lot in getting information from NVMEM
devices at non-static locations. One common example of NVMEM cell is the
MAC address that must be used. Sometimes the cell content is mainly (or
only) useful to the kernel, and sometimes it is not. Users might also
want to know the content of cells such as: the manufacturing place and
date, the hardware version, the unique ID, etc. Two possibilities in
this case: either the users re-implement their own parser to go through
the whole device and search for the information they want, or the kernel
can expose the content of the cells if deemed relevant. This second
approach sounds way more relevant than the first one to avoid useless
code duplication, so here is a series bringing NVMEM cells content to
the user through sysfs.

Here is a list of known limitations though:
* It is currently not possible to know whether the cell contains ASCII
  or binary data, so by default all cells are exposed in binary form.
* For now the implementation focuses on the read aspect. Technically
  speaking, in some cases, it could be acceptable to write the cells, I
  guess, but for now read-only files sound more than enough. A writable
  path can be added later anyway.
* The sysfs entries are created when the device probes, not when the
  NVMEM driver does. This means, if an NVMEM layout is used *and*
  compiled as a module *and* not installed properly in the system (a
  usermode helper tries to load the module otherwise), then the sysfs
  cells won't appear when the layout is actually insmod'ed because the
  sysfs folders/files have already been populated.

Thanks,
Miquèl

Miquel Raynal (2):
  ABI: sysfs-nvmem-cells: Expose cells through sysfs
  nvmem: core: Expose cells through sysfs

 Documentation/ABI/testing/sysfs-nvmem-cells |  21 +++
 drivers/nvmem/core.c                        | 135 +++++++++++++++++++-
 2 files changed, 152 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-nvmem-cells

-- 
2.34.1

