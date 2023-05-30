Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1982F7162DF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjE3OAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbjE3N7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:59:49 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D526114;
        Tue, 30 May 2023 06:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1685455177; x=1716991177;
  h=message-id:subject:from:to:cc:date:
   content-transfer-encoding:mime-version;
  bh=WTxGeWtdLxA1fy1Qf6/ncvVUwl/YJe960Ca7zRHAfPk=;
  b=NcJwE28GPRtiag/L6+tvF2xwPRSGyNlQSuD6yKNaMX+6ovwVX42bakTK
   DA/LuZwxZIAS4EXf/EYlQf5kJnTajiz7u7lrMiwKkOMf0tS0POvGfy4LX
   trpWtMb6vMa1vakCQcCiL1WWR5nISfJgUUepGN0fGwBAuwe/lAsTLU9Tp
   h+RjCBdbvxDIX99YrfU4GIpj5n7NHpXLa0JspDWPZR/OD5Lq1ZYj6DJ8G
   zpqWr59fc0ta5gNSMCAeW+TaBDAG/ku1SjR5jJVPDsCeuPlobY/qcfvLk
   MIsfVZAGNR6avRoJjqGu5mX74tTAW8NMyV4kP2jv9cBSNip0E+1R3GoBD
   g==;
X-IronPort-AV: E=Sophos;i="6.00,204,1681164000"; 
   d="scan'208";a="31170004"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 30 May 2023 15:59:35 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 30 May 2023 15:59:35 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 30 May 2023 15:59:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1685455175; x=1716991175;
  h=message-id:subject:from:to:cc:date:
   content-transfer-encoding:mime-version;
  bh=WTxGeWtdLxA1fy1Qf6/ncvVUwl/YJe960Ca7zRHAfPk=;
  b=WgtgYJfrsCN0NQBxsU+wO61VGm++zdvFg7Z9kzgw67z+dH11/aDBCesT
   XV9GcFW5B0lS166pCi046jf2vFIrtQw2f1KI+7jZ3zAPsN7K1/LDJFci0
   nmVx6BJEZYyyYIqlv+SZz7wV9uLHDOaCczjn3JKwbAIJMJVzCelfjfbGs
   ArJfevunVTH1Z7Mxw4zbkNa8p78bMxZ/pHVQ9eYtsz0uji8b58MsEqOo0
   /DMW9tWUnOIAg/S7n9cQzHBAlZcT5RnBqvk4CZV4VKO4TyVROugQ358aj
   8sOlNwtMDPMYjZhkaq28nbIQiCyQ0Eu6nKarjPGZtXTV1IMj5d8sIU1X6
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,204,1681164000"; 
   d="scan'208";a="31170003"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 30 May 2023 15:59:35 +0200
Received: from [192.168.2.129] (SCHIFFERM-M2.tq-net.de [10.121.49.20])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 15BB7280090;
        Tue, 30 May 2023 15:59:35 +0200 (CEST)
Message-ID: <b1ef61f5121149278b66d4cea99ba02b517fb0c9.camel@ew.tq-group.com>
Subject: Breaking change in st1232 multitouch support
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>
Cc:     Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
        Mark Brown <broonie@kernel.org>
Date:   Tue, 30 May 2023 15:59:34 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I've found that something strange has happened in the ST1232 driver:
Through Martin's patch that was supposed to add support for the ST1633
(commit 351e059 "Input: st1232 - add support for st1633") and a number
of subsequent fixes (b1a402e, 95c9ea9), the driver has come to not
actually support the ST1232 anymore, as the older ST1232/ST1332 and the
newer models (ST1633, various other) seem to have incompatible register
maps.

[1] shows the original register map, which assigns 3 registers to each
finger (0x12-0x14, 0x15-0x17), while [2] describes a different map
where 4 subsequent registers are assigned to each finger.

[2] does list "ST1x32" as a supported part though, but I'm not sure if
this is not supposed to include ST1232/ST1332, or if there was a
firmware update at some point that changed the register assignment.

If this breaking change was unintended, should the change be reverted
partially, so the code matches the ST1232/ST1332 datasheet again for
the "sitronix,st1232" compatible, and the new code is only used for
"sitronix,st1633"?

Adding Mark Brown to cc as a somewhat recent committer to a DTS that
references the "sitronix,st1232" compatible (imx6qdl-udoo), in the hope
that he has a matching display and could verify that multitouch is
indeed broken with recent kernels.

[1]
https://www.displayfuture.com/Display/datasheet/controller/ST1332.pdf
[2]
https://www.crystalfontz.com/products/document/4590/Sitronix_Touch_IC_Proto=
col_A_V2.7.pdf


Kind regards,
Matthias

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/

