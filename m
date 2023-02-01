Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92795686998
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjBAPK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbjBAPJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:09:47 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3940069B26;
        Wed,  1 Feb 2023 07:08:26 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id lu11so14978562ejb.3;
        Wed, 01 Feb 2023 07:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rp5plCaK+Ee0v6zJJSPg3nVKcz7Ocb0iI+K21w1Y4qU=;
        b=NRcPeMqBEWHBNfeM1QbytTGZ1tgUxGV947jrBR4ORmkwM2cjGj3VYO0Izn3sEkPeze
         TDSUaTP5zxyGloM9o75uwKb/ZyZk+fFS41eEBX/ap94gmlod2QhZDMBcdzZ+T6SWJIxm
         xuFMcqYWNXTFaAXiqxSzjvITMIqrA3UicyA6oKp7NZlv1V6pLdXCS4ya609Bdnz2D9Hi
         b9YuqWqFWdwJuTWGcraM1KZR1fSnQ3h7rueNOAopZZIlBcNIbA5q/QflEcWfVU8VhwXZ
         LsM4DihK15XNeSKhFz6YbZWMfSSGuU6F0Wy8Oq6rqwFlvmWH50agLQkQB+J8MR8Y3z3k
         S12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rp5plCaK+Ee0v6zJJSPg3nVKcz7Ocb0iI+K21w1Y4qU=;
        b=yQceJNKmuBB00xxZzAR1uTlwZUQY1IdE2Jv98ijCpejFbtBFUO6pg5dk85r0PcAf+/
         4bcfFzPI/tEGGzznpvOSAzUrCx6rxWpQdsm+opSod3HmEmANTmBrD6PuE+3tWdhixLVl
         qENeAPcP3CB12jr7Mrz4lxVVe+W6YASy3KhUxXLvJbqk0zxk6oE1ml2YLjZsXBTYTFT+
         hvSDs76UX4Gm4LbVRhOXaBh74v8mD6s4mTZXha9eEBb/5YffS2xD3g6R9PSx4q4ZrOXR
         NaQR0ZvWOtCV7gEJu4tAfBfkbJfzNusZwDD6v4yAxqKfg0M/pAvLQ6SrsQlg6EWNjeh4
         6KnQ==
X-Gm-Message-State: AO0yUKUnvqqw4FPA1lTMPE0zxU09pbIuNUBeO/hwZzQvI5IZ64F+cG6q
        r7YrfcgGuNlh3LXmZ2wuY6CipJWiFglyrw==
X-Google-Smtp-Source: AK7set8NF2CoMDa5EkVRC5udmJtZtSKjC3hoECJADkYaqeir3itK2k08NKHNlbPCOhBbCT7H7ScyXA==
X-Received: by 2002:a17:907:98f9:b0:87b:db62:d659 with SMTP id ke25-20020a17090798f900b0087bdb62d659mr3026308ejc.19.1675264105400;
        Wed, 01 Feb 2023 07:08:25 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id qc26-20020a170906d8ba00b008787e94c5ccsm9585774ejb.184.2023.02.01.07.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:08:25 -0800 (PST)
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
        Saeed Mahameed <saeedm@nvidia.com>,
        Vlad Buslov <vladbu@nvidia.com>
Subject: [PATCH 08/13] net/mlx5: Rename kfree_rcu() to kfree_rcu_mightsleep()
Date:   Wed,  1 Feb 2023 16:08:14 +0100
Message-Id: <20230201150815.409582-9-urezki@gmail.com>
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

Cc: Ariel Levkovich <lariel@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Vlad Buslov <vladbu@nvidia.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/int_port.c  | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/int_port.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/int_port.c
index ca834bbcb44f..8afcec0c5d3c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/int_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/int_port.c
@@ -242,7 +242,7 @@ mlx5e_int_port_remove(struct mlx5e_tc_int_port_priv *priv,
 		mlx5_del_flow_rules(int_port->rx_rule);
 	mapping_remove(ctx, int_port->mapping);
 	mlx5e_int_port_metadata_free(priv, int_port->match_metadata);
-	kfree_rcu(int_port);
+	kfree_rcu_mightsleep(int_port);
 	priv->num_ports--;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index 9369a580743e..5d32a8a5e5a4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -672,7 +672,7 @@ static int mlx5e_macsec_del_txsa(struct macsec_context *ctx)
 
 	mlx5e_macsec_cleanup_sa(macsec, tx_sa, true);
 	mlx5_destroy_encryption_key(macsec->mdev, tx_sa->enc_key_id);
-	kfree_rcu(tx_sa);
+	kfree_rcu_mightsleep(tx_sa);
 	macsec_device->tx_sa[assoc_num] = NULL;
 
 out:
@@ -851,7 +851,7 @@ static void macsec_del_rxsc_ctx(struct mlx5e_macsec *macsec, struct mlx5e_macsec
 	xa_erase(&macsec->sc_xarray, rx_sc->sc_xarray_element->fs_id);
 	metadata_dst_free(rx_sc->md_dst);
 	kfree(rx_sc->sc_xarray_element);
-	kfree_rcu(rx_sc);
+	kfree_rcu_mightsleep(rx_sc);
 }
 
 static int mlx5e_macsec_del_rxsc(struct macsec_context *ctx)
-- 
2.30.2

