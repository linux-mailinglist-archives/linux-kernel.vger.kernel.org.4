Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB5162CCB6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbiKPVfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbiKPVfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:35:50 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C42CD2F1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:35:47 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 9479C92009C; Wed, 16 Nov 2022 22:35:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 8D76092009B;
        Wed, 16 Nov 2022 21:35:46 +0000 (GMT)
Date:   Wed, 16 Nov 2022 21:35:46 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] parport_pc: Fixes for Oxford Semiconductor PCI/e parallel
 ports
Message-ID: <alpine.DEB.2.21.2211152336240.54611@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_HDRS_LCASE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 After several iterations I have now finally made my PCIe parallel port 
option card based on the Oxford Semiconductor OXPCIe952 ASIC work with my 
RISC-V system.

 This has turned out a generic incompatibility issue between our driver 
and somewhat quirky OxSemi hardware giving the same symptoms with an x86 
system as well, where the driver tries to use the Parallel Port FIFO mode, 
which is indeed documented by the relevant datasheets as not supported by 
OxSemi hardware.

 Additionally the hardware requires a specific bit pattern to be written 
into low 5 bits of ECR while poking at the mode in the high 3 bits, and 
while the OXPCIe952 implementation does not appear sensitive to it older 
ones seem to and may lock up according to our own history.

 This small patch series addresses these problems in 6 incremental steps.  
See individual change descriptions for further details.  I have verified 
these changes with and w/o PARPORT_PC_FIFO and PARPORT_1284 options set. 
Please apply.

  Maciej
