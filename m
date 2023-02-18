Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC2369BA52
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 14:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBRN60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 08:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBRN6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 08:58:25 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681AF144AB;
        Sat, 18 Feb 2023 05:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1676728697; i=w_armin@gmx.de;
        bh=HXc3Ky8K7EeeQh360fRePD6IF/Y8y+pNXQWwmdroHM0=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=VfufjnHT4sWi6RQuB7+0OjSe/wNzY6HPirdM3+tu23Aeo+0TqXmCmQJnLL+YfY8+z
         wzOjKf3rkuiVjy5huJz1m4h74/TiwmpE8h2PNACKw6/+UbH1FWXExJolTDNrY0G24a
         sd3MwRgZFGQI3RodnVSXZ0WxnriFprjOfwsKfKdta80bDnhneUyQ0Pw/GucByIs5PN
         au4UKyZcTsGMkQKAwuEdSzLtnR/JmK8CYeXqxUnQumZM4t0/VP56mdAMmgwfE9B1bj
         pzj45Kbj59G8LCTAbuoiZp8FALlRMnBz0FBEEEEWIbnAP24nmsBo449iuUlI3Kim4N
         fc5Yjsih6RsbQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDQeU-1pMGys43DK-00AUp6; Sat, 18
 Feb 2023 14:58:17 +0100
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Armin Wolf <W_Armin@gmx.de>
Subject: [BUG] sbs module causes lockup upon suspend/shutdown
Message-ID: <362d19fc-85f6-4bc4-46c5-1933113aec4f@gmx.de>
Date:   Sat, 18 Feb 2023 14:58:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:615DZe+B30EqDRNfKLkx3ehlDorQvPQxu+elYThWjQhe0iNFwgo
 zj3I3ruoUoYZKmWeLsbZRnTbaIN+OSo8HLXYaCRR8WZj1Uwsxl8bVfKPZztrnEP51ihU3Rg
 hoWcgGuuL+qqUwF3LQydtnGmTx7P2X+RRqpo6Ul3kHuZYgL3YlgG1FkjhGHYX3o4JqrnCbw
 KU7kkAYN+7EX2MxNLJG/Q==
UI-OutboundReport: notjunk:1;M01:P0:nmm+RFcx68I=;yhboy4aTIbFkXeFMvjvxCNhIcmh
 gR6QHFtDBqv76fpc0AesRVV1WtlkbBUb4O8nYyoVtulGKeZKvobb4lMWSzOp0vGffbtqrz1K4
 kqwxwcQt2X8P5y9VVcYB85SIe+HAZIBEMyQEmUmGJ5Qtd2gFDYfGRXba9cEVIXmtN6c19tG5E
 6YtrEQ6H7Fc3A0iC1wmDwoSuJ+MvFKgmT/cjf/b+CZWOzxqT1uRiteByWbVESyunSpsohOdGR
 ARAnMhFRk2nnh9H6hB+b92Are3vKpAUJwjRQB5Kt76oZ/RyPkwSwKwyBlrUqJZAlhWFJJrEAh
 oa5gLA2M+el7C946C1g+WuOELv5gvyq2ZeY5qQ4jW21WpVve+Tkn+897T+1ac5Vjjq6D1Hzrb
 qxDfeWv1RMN41SmY8Yd93SizJnE/kZfX6KwWXPR15qIf8smNQazxWVX3Jwz5GLIfUlxZC8doD
 EQSyIUpF47Ysl7pQbys20/tpcltOS4WnRkfGxU0WhoXhPYSCfK9fvUViYJLLGtpy01cgQ+9zj
 3kndTi26LvE2rZAHgGDvWXrEmx+DIPrwY32bmk7NASTEsRKalszfJw0DVmRHR5n6CUc33k8xZ
 CRDFrTr019T0lL7ryIqra5cWKGfjBkTP95FFddqGW9f6N82yaElQ6iG0iuXd4jOibglMzLV72
 cNXUPZE6/SkDPcsealRmXp5vHz7sV+/rwW4s33GUYrrhRfcI9Uw7TOoJjeqCbe0dydacFki9S
 7yxLmbd/B3e5AEglKSQ17WPKFSMahb1bBc9nWkOTcZfXi/xy2geUxsQ5tctcHch3er7V4tVqo
 7E7jb701pMhzabWTOjrWLthXRSvUOOn6sX6HY48J+2VZH64qJLYwCSPyz4CQKhU18FI1f+W4V
 c3J/n71X0hH4b12kaREnt5xHBr4+la9j+jgSUUs5ijfuPQyP5t0A0vs5Kv1mrNHlqeAZM+2OD
 5IdeZ569AGDQ1OLw64dVbSF+ZWw=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

on my Travelmate 4002WLMI, the sbs module causes a lockup upon suspend/shutdown when loaded.
Additionally, a kernel oops occurs when unloading the sbs module with "modprobe -r sbs", but
not with "rmmod sbs".

While i was able to fix the oops on module removal (a race condition similar to 757c968c4423,
but now inside the ACPI EC driver), i was unable to find the cause for the lockup.

I did however find out that the lockup does not occur when i reset the EC SMBus alert flag
before calling the handler function, to i suppose the issue lies inside the sbs alert callback
(maybe similar to add68d6aa9e2).

I created a bug report (https://bugzilla.kernel.org/show_bug.cgi?id=217041) with more information
attached, such as dmesg logs. Any  ideas on what causes the lockup?

Armin Wolf

