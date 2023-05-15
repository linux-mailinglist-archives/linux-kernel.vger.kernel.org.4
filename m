Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEAB703224
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242481AbjEOQFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242182AbjEOQFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:05:44 -0400
X-Greylist: delayed 193 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 May 2023 09:05:09 PDT
Received: from pku.edu.cn (mx19.pku.edu.cn [162.105.129.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47398E44;
        Mon, 15 May 2023 09:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding; bh=Z2kSEouUK5ALcnlaK77eH+hTTBVNdMFUed
        a5nYYd65Y=; b=NuaVhk4wftm9VB3gbKLQxqcucgJqrpnnFFujOmb0ksMs8GGYqG
        +HQ++H/Mv47XFNSKsYLdRjIGNU35JZJx8IZmjsiu9cr9/vdkrveK2vx+WWfRb4sk
        Bm47uJGardXJwIHpDxOaZn4cAvT6Pj9GwsSLl79UqAiqXXlxY5Ug1YfMY=
Received: from localhost.localdomain (unknown [10.7.98.243])
        by front02 (Coremail) with SMTP id 54FpogAHDU1PV2JkFco3FA--.0S2;
        Tue, 16 May 2023 00:01:37 +0800 (CST)
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com, marcel@holtmann.org
Cc:     syzbot+cf54c1da6574b6c1b049@syzkaller.appspotmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        Ruihan Li <lrh2000@pku.edu.cn>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_chan_del
Date:   Tue, 16 May 2023 00:01:19 +0800
Message-Id: <20230515160119.38957-1-lrh2000@pku.edu.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <00000000000013b93805fbbadc50@google.com>
References: <00000000000013b93805fbbadc50@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 54FpogAHDU1PV2JkFco3FA--.0S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr13GrWxWw17JFWrAryUtrb_yoW8GFWxpa
        yYv3Zaqr48Jwn5uanFkan7GrWkWrn5uFWjkry8XryrZ398trWDAa18Kr12qw45GFWkJF4U
        AFW8t3W7tay5G37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBa1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAac4AC62xK8x
        CEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80
        ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4
        AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY
        1x02628vn2kIc2xKxwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaV
        Av8VWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
        3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIx
        AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUlQ6LUUUUU=
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEMBVPy7743xAAKsD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that, while we remember to release unestablished SCO connections when
the ACL connection tears down (since [1]), we forget to call hci_connect_cfm
before hci_conn_del. Without hci_connect_cfm, the SCO socket may not be
notified to clean up its associated SCO connection (in sco_connect_cfm),
causing this use-after-free risk when operating the socket.

 [1] https://lore.kernel.org/linux-bluetooth/20230203173024.1.Ieb6662276f3bd3d79e9134ab04523d584c300c45@changeid/

However, I cannot figure out an easy and clear way to pass a proper error code
to hci_connect_cfm at this point, so I wonder if it is acceptable to use
HCI_ERROR_UNSPECIFIED directly. That said, the patch will look like this:

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index f75ef12f1..73c120258 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1102,8 +1102,10 @@ static void hci_conn_unlink(struct hci_conn *conn)
 			 */
 			if ((child->type == SCO_LINK ||
 			     child->type == ESCO_LINK) &&
-			    child->handle == HCI_CONN_HANDLE_UNSET)
+			    child->handle == HCI_CONN_HANDLE_UNSET) {
+				hci_connect_cfm(child, HCI_ERROR_UNSPECIFIED);
 				hci_conn_del(child);
+			}
 		}
 
 		return;

Also, while this fix can semantically be applied to v6.1 and above, an explicit
backport is required due to the hci_conn_unlink refactoring in the mainline.

Thanks,
Ruihan Li

