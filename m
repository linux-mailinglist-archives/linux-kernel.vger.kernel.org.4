Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4663968699B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbjBAPKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjBAPJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:09:44 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445BE6BBC1;
        Wed,  1 Feb 2023 07:08:28 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id dr8so30717619ejc.12;
        Wed, 01 Feb 2023 07:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCIsnGFwfhB3GdHRBSUurOPmrL4KoA1jNcMHDebxURA=;
        b=BoPO7gpLDoTuKhel0GzrIKGVr1TL37RGWdatMkKU0QJJY+2/5Q79vJ3ju3SNEP0hUi
         pS4R4XFaydaMFuGZ1BHFw2bOiaHCZz6cImmmpdB9bnx7OCWudj9X1EkAa8hpCqiDHkvc
         AXrztKeyxki0DyD7ogtOJXKnVZVw9gTLmZsrB71UvG2iScNVZ1fkXsxG7PoYXaaI38oE
         v8yTaTAe3z5sHYG7e/DL76rJRpPUCm6D5cH2rmKbyMa/oiQ9H+QJ3tfX+YGKRZRXqv31
         40m4gkFYfLThinnJF9d22bciAQBsclWsv27RAzxjq5qL8dNOk3NXmRxTNxF1pPv81S2j
         LGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCIsnGFwfhB3GdHRBSUurOPmrL4KoA1jNcMHDebxURA=;
        b=NH+oMjMNt8Y1lTUwXK3Kfr2jYif8DPhrd5IZv5w70ys9DT26WIeJ5rB01AOjibvSFI
         +TZlEddBS/hOoEMoz4GSnSiR3u3MuXIgjIdB9zP/EivmpCTPMg4ZzW3Pde9zGOuOpbA5
         lFXuTpjzC/koN6jta1acP2DeANYgnivZxrj60zGmUtfwxie5FUYo7K9UicBo7y3KC/GU
         TZt+DNCuUa35PM7vhnCUAAyZM6rZi3hDYDHlZ8S3EPE+OgVhGagw8wcww7Ve/HYL70Iz
         +GdwcgAIQq33Xa35WmAXQQmVhaIekNe41gzfA38N+K9I4IgGbEyqf/TRCWgzm8yekivF
         bekQ==
X-Gm-Message-State: AO0yUKWhbkLqVPv9H21eZAICnqaDYrznvHfU6OSO5eugEnavzb/cqvzW
        +dYDdboAMeBwN/OThAwwjHSDRsXRA0meYg==
X-Google-Smtp-Source: AK7set8Y/Z/c78ObALKOzGqUDP4vWGfAwQ4UcwS2igsc0DL0dqu01vIw+yZCyXzDj7ltwNPUfnHrtw==
X-Received: by 2002:a17:906:1441:b0:870:d15a:c2dc with SMTP id q1-20020a170906144100b00870d15ac2dcmr2800269ejc.74.1675264106371;
        Wed, 01 Feb 2023 07:08:26 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id qc26-20020a170906d8ba00b008787e94c5ccsm9585774ejb.184.2023.02.01.07.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:08:26 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>,
        Lukas Czerner <lczerner@redhat.com>
Subject: [PATCH 09/13] ext4/super: Rename kfree_rcu() to kfree_rcu_mightsleep()
Date:   Wed,  1 Feb 2023 16:08:15 +0100
Message-Id: <20230201150815.409582-10-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230201150815.409582-1-urezki@gmail.com>
References: <20230201150815.409582-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kfree_rcu()'s single argument name is deprecated therefore
rename it to kfree_rcu_mightsleep() variant. The goal is explicitly
underline that it is for sleepable contexts.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 260c1b3e3ef2..87aa23d047c9 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2500,7 +2500,7 @@ static void ext4_apply_quota_options(struct fs_context *fc,
 			qname = rcu_replace_pointer(sbi->s_qf_names[i], qname,
 						lockdep_is_held(&sb->s_umount));
 			if (qname)
-				kfree_rcu(qname);
+				kfree_rcu_mightsleep(qname);
 		}
 	}
 
-- 
2.30.2

