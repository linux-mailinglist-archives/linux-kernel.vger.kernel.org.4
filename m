Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486CB6ACB84
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjCFRyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjCFRya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:54:30 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 600BE474F1;
        Mon,  6 Mar 2023 09:53:56 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 0F72B7A06EC;
        Mon,  6 Mar 2023 18:28:29 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/18] pata_parport: remove typedef struct PIA
Date:   Mon,  6 Mar 2023 18:27:42 +0100
Message-Id: <20230306172752.7727-9-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230306172752.7727-1-linux@zary.sk>
References: <20230306172752.7727-1-linux@zary.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove typedef struct PIA and use struct pi_adapter directly.
Fix formatting (excessive spaces) while at it.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/aten.c  | 14 +++++++-------
 drivers/ata/pata_parport/bpck.c  | 24 ++++++++++++------------
 drivers/ata/pata_parport/bpck6.c | 22 +++++++++++-----------
 drivers/ata/pata_parport/comm.c  | 14 +++++++-------
 drivers/ata/pata_parport/dstr.c  | 14 +++++++-------
 drivers/ata/pata_parport/epat.c  | 16 ++++++++--------
 drivers/ata/pata_parport/epia.c  | 16 ++++++++--------
 drivers/ata/pata_parport/fit2.c  | 14 +++++++-------
 drivers/ata/pata_parport/fit3.c  | 14 +++++++-------
 drivers/ata/pata_parport/friq.c  | 20 ++++++++++----------
 drivers/ata/pata_parport/frpw.c  | 20 ++++++++++----------
 drivers/ata/pata_parport/kbic.c  | 24 ++++++++++++------------
 drivers/ata/pata_parport/ktti.c  | 14 +++++++-------
 drivers/ata/pata_parport/on20.c  | 14 +++++++-------
 drivers/ata/pata_parport/on26.c  | 16 ++++++++--------
 include/linux/pata_parport.h     |  2 --
 16 files changed, 128 insertions(+), 130 deletions(-)

diff --git a/drivers/ata/pata_parport/aten.c b/drivers/ata/pata_parport/aten.c
index bf83e4188c23..4579e554fbad 100644
--- a/drivers/ata/pata_parport/aten.c
+++ b/drivers/ata/pata_parport/aten.c
@@ -35,7 +35,7 @@
 
 static int  cont_map[2] = { 0x08, 0x20 };
 
-static void  aten_write_regr( PIA *pi, int cont, int regr, int val)
+static void aten_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
 
 {	int r;
 
@@ -44,7 +44,7 @@ static void  aten_write_regr( PIA *pi, int cont, int regr, int val)
 	w0(r); w2(0xe); w2(6); w0(val); w2(7); w2(6); w2(0xc);
 }
 
-static int aten_read_regr( PIA *pi, int cont, int regr )
+static int aten_read_regr(struct pi_adapter *pi, int cont, int regr)
 
 {	int  a, b, r;
 
@@ -67,7 +67,7 @@ static int aten_read_regr( PIA *pi, int cont, int regr )
 	return -1;
 }
 
-static void aten_read_block( PIA *pi, char * buf, int count )
+static void aten_read_block(struct pi_adapter *pi, char *buf, int count)
 
 {	int  k, a, b, c, d;
 
@@ -95,7 +95,7 @@ static void aten_read_block( PIA *pi, char * buf, int count )
 	}
 }
 
-static void aten_write_block( PIA *pi, char * buf, int count )
+static void aten_write_block(struct pi_adapter *pi, char *buf, int count)
 
 {	int k;
 
@@ -107,20 +107,20 @@ static void aten_write_block( PIA *pi, char * buf, int count )
 	w2(0xc);
 }
 
-static void aten_connect ( PIA *pi  )
+static void aten_connect(struct pi_adapter *pi)
 
 {       pi->saved_r0 = r0();
         pi->saved_r2 = r2();
 	w2(0xc);	
 }
 
-static void aten_disconnect ( PIA *pi )
+static void aten_disconnect(struct pi_adapter *pi)
 
 {       w0(pi->saved_r0);
         w2(pi->saved_r2);
 } 
 
-static void aten_log_adapter( PIA *pi, char * scratch, int verbose )
+static void aten_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
 
 {       char    *mode_string[2] = {"4-bit","8-bit"};
 
diff --git a/drivers/ata/pata_parport/bpck.c b/drivers/ata/pata_parport/bpck.c
index c33ca1cb72ac..46805c584730 100644
--- a/drivers/ata/pata_parport/bpck.c
+++ b/drivers/ata/pata_parport/bpck.c
@@ -46,7 +46,7 @@
 
 static int  cont_map[3] = { 0x40, 0x48, 0 };
 
-static int bpck_read_regr( PIA *pi, int cont, int regr )
+static int bpck_read_regr(struct pi_adapter *pi, int cont, int regr)
 
 {       int r, l, h;
 
@@ -77,7 +77,7 @@ static int bpck_read_regr( PIA *pi, int cont, int regr )
 	return -1;
 }	
 
-static void bpck_write_regr( PIA *pi, int cont, int regr, int val )
+static void bpck_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
 
 {	int	r;
 
@@ -106,7 +106,7 @@ static void bpck_write_regr( PIA *pi, int cont, int regr, int val )
 #define WR(r,v)		bpck_write_regr(pi,2,r,v)
 #define RR(r)		(bpck_read_regr(pi,2,r))
 
-static void bpck_write_block( PIA *pi, char * buf, int count )
+static void bpck_write_block(struct pi_adapter *pi, char *buf, int count)
 
 {	int i;
 
@@ -147,7 +147,7 @@ static void bpck_write_block( PIA *pi, char * buf, int count )
  	}
 }
 
-static void bpck_read_block( PIA *pi, char * buf, int count )
+static void bpck_read_block(struct pi_adapter *pi, char *buf, int count)
 
 {	int i, l, h;
 
@@ -194,7 +194,7 @@ static void bpck_read_block( PIA *pi, char * buf, int count )
 	}
 }
 
-static int bpck_probe_unit ( PIA *pi )
+static int bpck_probe_unit(struct pi_adapter *pi)
 
 {	int o1, o0, f7, id;
 	int t, s;
@@ -217,7 +217,7 @@ static int bpck_probe_unit ( PIA *pi )
 	return 1;
 }
 	
-static void bpck_connect ( PIA *pi  )
+static void bpck_connect(struct pi_adapter *pi)
 
 {       pi->saved_r0 = r0();
 	w0(0xff-pi->unit); w2(4); w0(pi->unit);
@@ -251,14 +251,14 @@ static void bpck_connect ( PIA *pi  )
 /*	}*/
 }
 
-static void bpck_disconnect ( PIA *pi )
+static void bpck_disconnect(struct pi_adapter *pi)
 
 {	w0(0); 
 	if (pi->mode >= 2) { w2(9); w2(0); } else t2(2);
 	w2(0x4c); w0(pi->saved_r0);
 } 
 
-static void bpck_force_spp ( PIA *pi )
+static void bpck_force_spp(struct pi_adapter *pi)
 
 /* This fakes the EPP protocol to turn off EPP ... */
 
@@ -276,7 +276,7 @@ static void bpck_force_spp ( PIA *pi )
 
 #define TEST_LEN  16
 
-static int bpck_test_proto( PIA *pi, char * scratch, int verbose )
+static int bpck_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
 
 {	int i, e, l, h, om;
 	char buf[TEST_LEN];
@@ -346,7 +346,7 @@ static int bpck_test_proto( PIA *pi, char * scratch, int verbose )
 	return e;
 }
 
-static void bpck_read_eeprom ( PIA *pi, char * buf )
+static void bpck_read_eeprom(struct pi_adapter *pi, char *buf)
 
 {       int i, j, k, p, v, f, om, od;
 
@@ -397,7 +397,7 @@ static void bpck_read_eeprom ( PIA *pi, char * buf )
 	pi->mode = om; pi->delay = od;
 }
 
-static int bpck_test_port ( PIA *pi ) 	/* check for 8-bit port */
+static int bpck_test_port(struct pi_adapter *pi)	/* check for 8-bit port */
 
 {	int	i, r, m;
 
@@ -416,7 +416,7 @@ static int bpck_test_port ( PIA *pi ) 	/* check for 8-bit port */
 	return 5;
 }
 
-static void bpck_log_adapter( PIA *pi, char * scratch, int verbose )
+static void bpck_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
 
 {	char	*mode_string[5] = { "4-bit","8-bit","EPP-8",
 				    "EPP-16","EPP-32" };
diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index 13bfd60655dd..8ed3cf3b627e 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -56,7 +56,7 @@ static bool verbose; /* set this to 1 to see debugging messages and whatnot */
 #define ATAPI_DEVICE_CONTROL 0x0e /* device control (write)   */
 /****************************************************************/
 
-static int bpck6_read_regr(PIA *pi, int cont, int reg)
+static int bpck6_read_regr(struct pi_adapter *pi, int cont, int reg)
 {
 	unsigned int out;
 
@@ -69,7 +69,7 @@ static int bpck6_read_regr(PIA *pi, int cont, int reg)
 	return(out);
 }
 
-static void bpck6_write_regr(PIA *pi, int cont, int reg, int val)
+static void bpck6_write_regr(struct pi_adapter *pi, int cont, int reg, int val)
 {
 	/* check for bad settings */
 	if (reg>=0 && reg<=7 && cont>=0 && cont<=1)
@@ -78,17 +78,17 @@ static void bpck6_write_regr(PIA *pi, int cont, int reg, int val)
 	}
 }
 
-static void bpck6_write_block( PIA *pi, char * buf, int len )
+static void bpck6_write_block(struct pi_adapter *pi, char *buf, int len)
 {
 	ppc6_wr_port16_blk(PPCSTRUCT(pi),ATAPI_DATA,buf,(u32)len>>1); 
 }
 
-static void bpck6_read_block( PIA *pi, char * buf, int len )
+static void bpck6_read_block(struct pi_adapter *pi, char *buf, int len)
 {
 	ppc6_rd_port16_blk(PPCSTRUCT(pi),ATAPI_DATA,buf,(u32)len>>1);
 }
 
-static void bpck6_connect ( PIA *pi  )
+static void bpck6_connect(struct pi_adapter *pi)
 {
 	if(verbose)
 	{
@@ -112,7 +112,7 @@ static void bpck6_connect ( PIA *pi  )
 	ppc6_wr_extout(PPCSTRUCT(pi),0x3);
 }
 
-static void bpck6_disconnect ( PIA *pi )
+static void bpck6_disconnect(struct pi_adapter *pi)
 {
 	if(verbose)
 	{
@@ -122,7 +122,7 @@ static void bpck6_disconnect ( PIA *pi )
 	ppc6_close(PPCSTRUCT(pi));
 }
 
-static int bpck6_test_port ( PIA *pi )   /* check for 8-bit port */
+static int bpck6_test_port(struct pi_adapter *pi)   /* check for 8-bit port */
 {
 	if(verbose)
 	{
@@ -154,7 +154,7 @@ static int bpck6_test_port ( PIA *pi )   /* check for 8-bit port */
 	}
 }
 
-static int bpck6_probe_unit ( PIA *pi )
+static int bpck6_probe_unit(struct pi_adapter *pi)
 {
 	int out;
 
@@ -195,7 +195,7 @@ static int bpck6_probe_unit ( PIA *pi )
   	}
 }
 
-static void bpck6_log_adapter( PIA *pi, char * scratch, int verbose )
+static void bpck6_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
 {
 	char *mode_string[5]=
 		{"4-bit","8-bit","EPP-8","EPP-16","EPP-32"};
@@ -206,7 +206,7 @@ static void bpck6_log_adapter( PIA *pi, char * scratch, int verbose )
 		pi->unit,pi->mode,mode_string[pi->mode],pi->delay);
 }
 
-static int bpck6_init_proto(PIA *pi)
+static int bpck6_init_proto(struct pi_adapter *pi)
 {
 	Interface *p = kzalloc(sizeof(Interface), GFP_KERNEL);
 
@@ -219,7 +219,7 @@ static int bpck6_init_proto(PIA *pi)
 	return -1;
 }
 
-static void bpck6_release_proto(PIA *pi)
+static void bpck6_release_proto(struct pi_adapter *pi)
 {
 	kfree((void *)(pi->private)); 
 }
diff --git a/drivers/ata/pata_parport/comm.c b/drivers/ata/pata_parport/comm.c
index 908f6c44548b..06c6fa29295b 100644
--- a/drivers/ata/pata_parport/comm.c
+++ b/drivers/ata/pata_parport/comm.c
@@ -42,7 +42,7 @@
 
 static int  cont_map[2] = { 0x08, 0x10 };
 
-static int comm_read_regr( PIA *pi, int cont, int regr )
+static int comm_read_regr(struct pi_adapter *pi, int cont, int regr)
 
 {       int     l, h, r;
 
@@ -68,7 +68,7 @@ static int comm_read_regr( PIA *pi, int cont, int regr )
         return -1;
 }       
 
-static void comm_write_regr( PIA *pi, int cont, int regr, int val )
+static void comm_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
 
 {       int  r;
 
@@ -87,7 +87,7 @@ static void comm_write_regr( PIA *pi, int cont, int regr, int val )
         }
 }
 
-static void comm_connect ( PIA *pi  )
+static void comm_connect(struct pi_adapter *pi)
 
 {       pi->saved_r0 = r0();
         pi->saved_r2 = r2();
@@ -98,14 +98,14 @@ static void comm_connect ( PIA *pi  )
         w2(4); w0(0xe0); w2(0xc); w2(0xc); w2(4);
 }
 
-static void comm_disconnect ( PIA *pi )
+static void comm_disconnect(struct pi_adapter *pi)
 
 {       w2(0); w2(0); w2(0); w2(4); 
 	w0(pi->saved_r0);
         w2(pi->saved_r2);
 } 
 
-static void comm_read_block( PIA *pi, char * buf, int count )
+static void comm_read_block(struct pi_adapter *pi, char *buf, int count)
 
 {       int     i, l, h;
 
@@ -146,7 +146,7 @@ static void comm_read_block( PIA *pi, char * buf, int count )
 
 /* NB: Watch out for the byte swapped writes ! */
 
-static void comm_write_block( PIA *pi, char * buf, int count )
+static void comm_write_block(struct pi_adapter *pi, char *buf, int count)
 
 {       int	k;
 
@@ -179,7 +179,7 @@ static void comm_write_block( PIA *pi, char * buf, int count )
         }
 }
 
-static void comm_log_adapter( PIA *pi, char * scratch, int verbose )
+static void comm_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
 
 {       char    *mode_string[5] = {"4-bit","8-bit","EPP-8","EPP-16","EPP-32"};
 
diff --git a/drivers/ata/pata_parport/dstr.c b/drivers/ata/pata_parport/dstr.c
index 3732e9b79429..8cac71eb9c03 100644
--- a/drivers/ata/pata_parport/dstr.c
+++ b/drivers/ata/pata_parport/dstr.c
@@ -44,7 +44,7 @@
 
 static int  cont_map[2] = { 0x20, 0x40 };
 
-static int dstr_read_regr( PIA *pi, int cont, int regr )
+static int dstr_read_regr(struct pi_adapter *pi, int cont, int regr)
 
 {       int     a, b, r;
 
@@ -71,7 +71,7 @@ static int dstr_read_regr( PIA *pi, int cont, int regr )
         return -1;
 }       
 
-static void dstr_write_regr(  PIA *pi, int cont, int regr, int val )
+static void dstr_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
 
 {       int  r;
 
@@ -98,21 +98,21 @@ static void dstr_write_regr(  PIA *pi, int cont, int regr, int val )
 		 w0(0xaa);w0(0x55);w0(0);w0(0xff);w0(0x87);w0(0x78);\
 		 w0(x);w2(5);w2(4);
 
-static void dstr_connect ( PIA *pi  )
+static void dstr_connect(struct pi_adapter *pi)
 
 {       pi->saved_r0 = r0();
         pi->saved_r2 = r2();
         w2(4); CCP(0xe0); w0(0xff);
 }
 
-static void dstr_disconnect ( PIA *pi )
+static void dstr_disconnect(struct pi_adapter *pi)
 
 {       CCP(0x30);
         w0(pi->saved_r0);
         w2(pi->saved_r2);
 } 
 
-static void dstr_read_block( PIA *pi, char * buf, int count )
+static void dstr_read_block(struct pi_adapter *pi, char *buf, int count)
 
 {       int     k, a, b;
 
@@ -154,7 +154,7 @@ static void dstr_read_block( PIA *pi, char * buf, int count )
         }
 }
 
-static void dstr_write_block( PIA *pi, char * buf, int count )
+static void dstr_write_block(struct pi_adapter *pi, char *buf, int count)
 
 {       int	k;
 
@@ -190,7 +190,7 @@ static void dstr_write_block( PIA *pi, char * buf, int count )
 }
 
 
-static void dstr_log_adapter( PIA *pi, char * scratch, int verbose )
+static void dstr_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
 
 {       char    *mode_string[5] = {"4-bit","8-bit","EPP-8",
 				   "EPP-16","EPP-32"};
diff --git a/drivers/ata/pata_parport/epat.c b/drivers/ata/pata_parport/epat.c
index 59720daa9c19..9276dcb261d8 100644
--- a/drivers/ata/pata_parport/epat.c
+++ b/drivers/ata/pata_parport/epat.c
@@ -44,7 +44,7 @@ MODULE_PARM_DESC(epatc8, "support for the Shuttle EP1284 chip, "
 
 static int cont_map[3] = { 0x18, 0x10, 0 };
 
-static void epat_write_regr( PIA *pi, int cont, int regr, int val)
+static void epat_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
 
 {	int r;
 
@@ -65,7 +65,7 @@ static void epat_write_regr( PIA *pi, int cont, int regr, int val)
 	}
 }
 
-static int epat_read_regr( PIA *pi, int cont, int regr )
+static int epat_read_regr(struct pi_adapter *pi, int cont, int regr)
 
 {	int  a, b, r;
 
@@ -94,7 +94,7 @@ static int epat_read_regr( PIA *pi, int cont, int regr )
 	return -1;	/* never gets here */
 }
 
-static void epat_read_block( PIA *pi, char * buf, int count )
+static void epat_read_block(struct pi_adapter *pi, char *buf, int count)
 
 {	int  k, ph, a, b;
 
@@ -159,7 +159,7 @@ static void epat_read_block( PIA *pi, char * buf, int count )
 	}
 }
 
-static void epat_write_block( PIA *pi, char * buf, int count )   
+static void epat_write_block(struct pi_adapter *pi, char *buf, int count)
 
 {	int ph, k;
 
@@ -210,7 +210,7 @@ static void epat_write_block( PIA *pi, char * buf, int count )
 #define CPP(x) 	w2(4);w0(0x22);w0(0xaa);w0(0x55);w0(0);w0(0xff);\
                 w0(0x87);w0(0x78);w0(x);w2(4);w2(5);w2(4);w0(0xff);
 
-static void epat_connect ( PIA *pi )
+static void epat_connect(struct pi_adapter *pi)
 
 {       pi->saved_r0 = r0();
         pi->saved_r2 = r2();
@@ -242,13 +242,13 @@ static void epat_connect ( PIA *pi )
 	}
 }
 
-static void epat_disconnect (PIA *pi)
+static void epat_disconnect(struct pi_adapter *pi)
 {	CPP(0x30);
 	w0(pi->saved_r0);
 	w2(pi->saved_r2);
 }
 
-static int epat_test_proto( PIA *pi, char * scratch, int verbose )
+static int epat_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
 
 {       int     k, j, f, cc;
 	int	e[2] = {0,0};
@@ -287,7 +287,7 @@ static int epat_test_proto( PIA *pi, char * scratch, int verbose )
         return (e[0] && e[1]) || f;
 }
 
-static void epat_log_adapter( PIA *pi, char * scratch, int verbose )
+static void epat_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
 
 {	int	ver;
         char    *mode_string[6] = 
diff --git a/drivers/ata/pata_parport/epia.c b/drivers/ata/pata_parport/epia.c
index 610269083441..85b1aba995e1 100644
--- a/drivers/ata/pata_parport/epia.c
+++ b/drivers/ata/pata_parport/epia.c
@@ -46,7 +46,7 @@
 
 static int cont_map[2] = { 0, 0x80 };
 
-static int epia_read_regr( PIA *pi, int cont, int regr )
+static int epia_read_regr(struct pi_adapter *pi, int cont, int regr)
 
 {       int     a, b, r;
 
@@ -79,7 +79,7 @@ static int epia_read_regr( PIA *pi, int cont, int regr )
         return -1;
 }       
 
-static void epia_write_regr( PIA *pi, int cont, int regr, int val)
+static void epia_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
 
 {       int  r;
 
@@ -110,7 +110,7 @@ static void epia_write_regr( PIA *pi, int cont, int regr, int val)
    2048 byte reads (the last two being used in the CDrom drivers.
 */
 
-static void epia_connect ( PIA *pi  )
+static void epia_connect(struct pi_adapter *pi)
 
 {       pi->saved_r0 = r0();
         pi->saved_r2 = r2();
@@ -124,7 +124,7 @@ static void epia_connect ( PIA *pi  )
         WR(0x86,8);  
 }
 
-static void epia_disconnect ( PIA *pi )
+static void epia_disconnect(struct pi_adapter *pi)
 
 {       /* WR(0x84,0x10); */
         w0(pi->saved_r0);
@@ -133,7 +133,7 @@ static void epia_disconnect ( PIA *pi )
         w2(pi->saved_r2);
 } 
 
-static void epia_read_block( PIA *pi, char * buf, int count )
+static void epia_read_block(struct pi_adapter *pi, char *buf, int count)
 
 {       int     k, ph, a, b;
 
@@ -193,7 +193,7 @@ static void epia_read_block( PIA *pi, char * buf, int count )
         }
 }
 
-static void epia_write_block( PIA *pi, char * buf, int count )
+static void epia_write_block(struct pi_adapter *pi, char *buf, int count)
 
 {       int     ph, k, last, d;
 
@@ -234,7 +234,7 @@ static void epia_write_block( PIA *pi, char * buf, int count )
 
 }
 
-static int epia_test_proto( PIA *pi, char * scratch, int verbose )
+static int epia_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
 
 {       int     j, k, f;
 	int	e[2] = {0,0};
@@ -272,7 +272,7 @@ static int epia_test_proto( PIA *pi, char * scratch, int verbose )
 }
 
 
-static void epia_log_adapter( PIA *pi, char * scratch, int verbose )
+static void epia_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
 
 {       char    *mode_string[6] = {"4-bit","5/3","8-bit",
 				   "EPP-8","EPP-16","EPP-32"};
diff --git a/drivers/ata/pata_parport/fit2.c b/drivers/ata/pata_parport/fit2.c
index 28de8e4e41c3..67e095d6a718 100644
--- a/drivers/ata/pata_parport/fit2.c
+++ b/drivers/ata/pata_parport/fit2.c
@@ -37,13 +37,13 @@ devices.
 
 */
 
-static void  fit2_write_regr( PIA *pi, int cont, int regr, int val)
+static void fit2_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
 
 {	if (cont == 1) return;
 	w2(0xc); w0(regr); w2(4); w0(val); w2(5); w0(0); w2(4);
 }
 
-static int fit2_read_regr( PIA *pi, int cont, int regr )
+static int fit2_read_regr(struct pi_adapter *pi, int cont, int regr)
 
 {	int  a, b, r;
 
@@ -61,7 +61,7 @@ static int fit2_read_regr( PIA *pi, int cont, int regr )
 
 }
 
-static void fit2_read_block( PIA *pi, char * buf, int count )
+static void fit2_read_block(struct pi_adapter *pi, char *buf, int count)
 
 {	int  k, a, b, c, d;
 
@@ -87,7 +87,7 @@ static void fit2_read_block( PIA *pi, char * buf, int count )
 
 }
 
-static void fit2_write_block( PIA *pi, char * buf, int count )
+static void fit2_write_block(struct pi_adapter *pi, char *buf, int count)
 
 {	int k;
 
@@ -100,20 +100,20 @@ static void fit2_write_block( PIA *pi, char * buf, int count )
 	w2(4);
 }
 
-static void fit2_connect ( PIA *pi  )
+static void fit2_connect(struct pi_adapter *pi)
 
 {       pi->saved_r0 = r0();
         pi->saved_r2 = r2();
 	w2(0xcc); 
 }
 
-static void fit2_disconnect ( PIA *pi )
+static void fit2_disconnect(struct pi_adapter *pi)
 
 {       w0(pi->saved_r0);
         w2(pi->saved_r2);
 } 
 
-static void fit2_log_adapter( PIA *pi, char * scratch, int verbose )
+static void fit2_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
 
 {
 	printk("fit2 %s, FIT 2000 adapter at 0x%x, delay %d\n",
diff --git a/drivers/ata/pata_parport/fit3.c b/drivers/ata/pata_parport/fit3.c
index 0366f3123508..01e862a94b96 100644
--- a/drivers/ata/pata_parport/fit3.c
+++ b/drivers/ata/pata_parport/fit3.c
@@ -39,7 +39,7 @@
 
 */
 
-static void  fit3_write_regr( PIA *pi, int cont, int regr, int val)
+static void fit3_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
 
 {	if (cont == 1) return;
 
@@ -59,7 +59,7 @@ static void  fit3_write_regr( PIA *pi, int cont, int regr, int val)
 	}
 }
 
-static int fit3_read_regr( PIA *pi, int cont, int regr )
+static int fit3_read_regr(struct pi_adapter *pi, int cont, int regr)
 
 {	int  a, b;
 
@@ -92,7 +92,7 @@ static int fit3_read_regr( PIA *pi, int cont, int regr )
 
 }
 
-static void fit3_read_block( PIA *pi, char * buf, int count )
+static void fit3_read_block(struct pi_adapter *pi, char *buf, int count)
 
 {	int  k, a, b, c, d;
 
@@ -131,7 +131,7 @@ static void fit3_read_block( PIA *pi, char * buf, int count )
 	}
 }
 
-static void fit3_write_block( PIA *pi, char * buf, int count )
+static void fit3_write_block(struct pi_adapter *pi, char *buf, int count)
 
 {	int k;
 
@@ -152,7 +152,7 @@ static void fit3_write_block( PIA *pi, char * buf, int count )
 	}
 }
 
-static void fit3_connect ( PIA *pi  )
+static void fit3_connect(struct pi_adapter *pi)
 
 {       pi->saved_r0 = r0();
         pi->saved_r2 = r2();
@@ -162,14 +162,14 @@ static void fit3_connect ( PIA *pi  )
 		}
 }
 
-static void fit3_disconnect ( PIA *pi )
+static void fit3_disconnect(struct pi_adapter *pi)
 
 {       w2(0xc); w0(0xa); w2(0x8); w2(0xc);
 	w0(pi->saved_r0);
         w2(pi->saved_r2);
 } 
 
-static void fit3_log_adapter( PIA *pi, char * scratch, int verbose )
+static void fit3_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
 
 {       char    *mode_string[3] = {"4-bit","8-bit","EPP"};
 
diff --git a/drivers/ata/pata_parport/friq.c b/drivers/ata/pata_parport/friq.c
index 9306a2c78d90..9f8f4e6b1a7c 100644
--- a/drivers/ata/pata_parport/friq.c
+++ b/drivers/ata/pata_parport/friq.c
@@ -48,7 +48,7 @@
 
 static int  cont_map[2] = { 0x08, 0x10 };
 
-static int friq_read_regr( PIA *pi, int cont, int regr )
+static int friq_read_regr(struct pi_adapter *pi, int cont, int regr)
 
 {	int	h,l,r;
 
@@ -63,7 +63,7 @@ static int friq_read_regr( PIA *pi, int cont, int regr )
 
 }
 
-static void friq_write_regr( PIA *pi, int cont, int regr, int val)
+static void friq_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
 
 {	int r;
 
@@ -74,7 +74,7 @@ static void friq_write_regr( PIA *pi, int cont, int regr, int val)
 	w2(5);w2(7);w2(5);w2(4);
 }
 
-static void friq_read_block_int( PIA *pi, char * buf, int count, int regr )
+static void friq_read_block_int(struct pi_adapter *pi, char *buf, int count, int regr)
 
 {       int     h, l, k, ph;
 
@@ -129,12 +129,12 @@ static void friq_read_block_int( PIA *pi, char * buf, int count, int regr )
         }
 }
 
-static void friq_read_block( PIA *pi, char * buf, int count)
+static void friq_read_block(struct pi_adapter *pi, char *buf, int count)
 
 {	friq_read_block_int(pi,buf,count,0x08);
 }
 
-static void friq_write_block( PIA *pi, char * buf, int count )
+static void friq_write_block(struct pi_adapter *pi, char *buf, int count)
  
 {	int	k;
 
@@ -166,21 +166,21 @@ static void friq_write_block( PIA *pi, char * buf, int count )
 	}
 }
 
-static void friq_connect ( PIA *pi  )
+static void friq_connect(struct pi_adapter *pi)
 
 {       pi->saved_r0 = r0();
         pi->saved_r2 = r2();
 	w2(4);
 }
 
-static void friq_disconnect ( PIA *pi )
+static void friq_disconnect(struct pi_adapter *pi)
 
 {       CMD(0x20);
 	w0(pi->saved_r0);
         w2(pi->saved_r2);
 } 
 
-static int friq_test_proto( PIA *pi, char * scratch, int verbose )
+static int friq_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
 
 {       int     j, k, r;
 	int	e[2] = {0,0};
@@ -216,7 +216,7 @@ static int friq_test_proto( PIA *pi, char * scratch, int verbose )
 }
 
 
-static void friq_log_adapter( PIA *pi, char * scratch, int verbose )
+static void friq_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
 
 {       char    *mode_string[6] = {"4-bit","8-bit",
 				   "EPP-8","EPP-16","EPP-32"};
@@ -233,7 +233,7 @@ static void friq_log_adapter( PIA *pi, char * scratch, int verbose )
 
 }
 
-static void friq_release_proto( PIA *pi)
+static void friq_release_proto(struct pi_adapter *pi)
 {
 	if (pi->private) {		/* turn off the power */
 		friq_connect(pi);
diff --git a/drivers/ata/pata_parport/frpw.c b/drivers/ata/pata_parport/frpw.c
index 63f2165fec63..e93570190dab 100644
--- a/drivers/ata/pata_parport/frpw.c
+++ b/drivers/ata/pata_parport/frpw.c
@@ -44,7 +44,7 @@
 
 static int  cont_map[2] = { 0x08, 0x10 };
 
-static int frpw_read_regr( PIA *pi, int cont, int regr )
+static int frpw_read_regr(struct pi_adapter *pi, int cont, int regr)
 
 {	int	h,l,r;
 
@@ -60,7 +60,7 @@ static int frpw_read_regr( PIA *pi, int cont, int regr )
 
 }
 
-static void frpw_write_regr( PIA *pi, int cont, int regr, int val)
+static void frpw_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
 
 {	int r;
 
@@ -71,7 +71,7 @@ static void frpw_write_regr( PIA *pi, int cont, int regr, int val)
 	w2(5);w2(7);w2(5);w2(4);
 }
 
-static void frpw_read_block_int( PIA *pi, char * buf, int count, int regr )
+static void frpw_read_block_int(struct pi_adapter *pi, char *buf, int count, int regr)
 
 {       int     h, l, k, ph;
 
@@ -132,12 +132,12 @@ static void frpw_read_block_int( PIA *pi, char * buf, int count, int regr )
         }
 }
 
-static void frpw_read_block( PIA *pi, char * buf, int count)
+static void frpw_read_block(struct pi_adapter *pi, char *buf, int count)
 
 {	frpw_read_block_int(pi,buf,count,0x08);
 }
 
-static void frpw_write_block( PIA *pi, char * buf, int count )
+static void frpw_write_block(struct pi_adapter *pi, char *buf, int count)
  
 {	int	k;
 
@@ -170,14 +170,14 @@ static void frpw_write_block( PIA *pi, char * buf, int count )
 	}
 }
 
-static void frpw_connect ( PIA *pi  )
+static void frpw_connect(struct pi_adapter *pi)
 
 {       pi->saved_r0 = r0();
         pi->saved_r2 = r2();
 	w2(4);
 }
 
-static void frpw_disconnect ( PIA *pi )
+static void frpw_disconnect(struct pi_adapter *pi)
 
 {       w2(4); w0(0x20); cec4;
 	w0(pi->saved_r0);
@@ -188,7 +188,7 @@ static void frpw_disconnect ( PIA *pi )
    between the Xilinx and ASIC implementations of the Freecom adapter.
 */
 
-static int frpw_test_pnp ( PIA *pi )
+static int frpw_test_pnp(struct pi_adapter *pi)
 
 /*  returns chip_type:   0 = Xilinx, 1 = ASIC   */
 
@@ -221,7 +221,7 @@ static int frpw_test_pnp ( PIA *pi )
    a hack :-(
 */
 
-static int frpw_test_proto( PIA *pi, char * scratch, int verbose )
+static int frpw_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
 
 {       int     j, k, r;
 	int	e[2] = {0,0};
@@ -267,7 +267,7 @@ static int frpw_test_proto( PIA *pi, char * scratch, int verbose )
 }
 
 
-static void frpw_log_adapter( PIA *pi, char * scratch, int verbose )
+static void frpw_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
 
 {       char    *mode_string[6] = {"4-bit","8-bit","EPP",
 				   "EPP-8","EPP-16","EPP-32"};
diff --git a/drivers/ata/pata_parport/kbic.c b/drivers/ata/pata_parport/kbic.c
index 9a99b9e35d41..fffb79054144 100644
--- a/drivers/ata/pata_parport/kbic.c
+++ b/drivers/ata/pata_parport/kbic.c
@@ -42,7 +42,7 @@
 
 static int  cont_map[2] = { 0x80, 0x40 };
 
-static int kbic_read_regr( PIA *pi, int cont, int regr )
+static int kbic_read_regr(struct pi_adapter *pi, int cont, int regr)
 
 {       int     a, b, s;
 
@@ -72,7 +72,7 @@ static int kbic_read_regr( PIA *pi, int cont, int regr )
 	return -1;
 }       
 
-static void  kbic_write_regr( PIA *pi, int cont, int regr, int val)
+static void kbic_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
 
 {       int  s;
 
@@ -96,14 +96,14 @@ static void  kbic_write_regr( PIA *pi, int cont, int regr, int val)
 	}
 }
 
-static void k951_connect ( PIA *pi  )
+static void k951_connect(struct pi_adapter *pi)
 
 { 	pi->saved_r0 = r0();
         pi->saved_r2 = r2();
         w2(4); 
 }
 
-static void k951_disconnect ( PIA *pi )
+static void k951_disconnect(struct pi_adapter *pi)
 
 {      	w0(pi->saved_r0);
         w2(pi->saved_r2);
@@ -112,7 +112,7 @@ static void k951_disconnect ( PIA *pi )
 #define	CCP(x)	w2(0xc4);w0(0xaa);w0(0x55);w0(0);w0(0xff);w0(0x87);\
 		w0(0x78);w0(x);w2(0xc5);w2(0xc4);w0(0xff);
 
-static void k971_connect ( PIA *pi  )
+static void k971_connect(struct pi_adapter *pi)
 
 { 	pi->saved_r0 = r0();
         pi->saved_r2 = r2();
@@ -120,7 +120,7 @@ static void k971_connect ( PIA *pi  )
         w2(4); 
 }
 
-static void k971_disconnect ( PIA *pi )
+static void k971_disconnect(struct pi_adapter *pi)
 
 {       CCP(0x30);
 	w0(pi->saved_r0);
@@ -131,7 +131,7 @@ static void k971_disconnect ( PIA *pi )
    have this property.
 */
 
-static void kbic_read_block( PIA *pi, char * buf, int count )
+static void kbic_read_block(struct pi_adapter *pi, char *buf, int count)
 
 {       int     k, a, b;
 
@@ -189,7 +189,7 @@ static void kbic_read_block( PIA *pi, char * buf, int count )
         }
 }
 
-static void kbic_write_block( PIA *pi, char * buf, int count )
+static void kbic_write_block(struct pi_adapter *pi, char *buf, int count)
 
 {       int     k;
 
@@ -229,8 +229,8 @@ static void kbic_write_block( PIA *pi, char * buf, int count )
 
 }
 
-static void kbic_log_adapter( PIA *pi, char * scratch, 
-			      int verbose, char * chip )
+static void kbic_log_adapter(struct pi_adapter *pi, char *scratch,
+			      int verbose, char *chip)
 
 {       char    *mode_string[6] = {"4-bit","5/3","8-bit",
 				   "EPP-8","EPP_16","EPP-32"};
@@ -241,12 +241,12 @@ static void kbic_log_adapter( PIA *pi, char * scratch,
 
 }
 
-static void k951_log_adapter( PIA *pi, char * scratch, int verbose )
+static void k951_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
 
 {	kbic_log_adapter(pi,scratch,verbose,"KBIC-951A");
 }
 
-static void k971_log_adapter( PIA *pi, char * scratch, int verbose )
+static void k971_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
 
 {       kbic_log_adapter(pi,scratch,verbose,"KBIC-971A");
 }
diff --git a/drivers/ata/pata_parport/ktti.c b/drivers/ata/pata_parport/ktti.c
index d87eb3c139bc..ffb2af0ce045 100644
--- a/drivers/ata/pata_parport/ktti.c
+++ b/drivers/ata/pata_parport/ktti.c
@@ -29,7 +29,7 @@
 
 static int  cont_map[2] = { 0x10, 0x08 };
 
-static void  ktti_write_regr( PIA *pi, int cont, int regr, int val)
+static void ktti_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
 
 {	int r;
 
@@ -39,7 +39,7 @@ static void  ktti_write_regr( PIA *pi, int cont, int regr, int val)
 	w0(val); w2(3); w0(0); w2(6); w2(0xb);
 }
 
-static int ktti_read_regr( PIA *pi, int cont, int regr )
+static int ktti_read_regr(struct pi_adapter *pi, int cont, int regr)
 
 {	int  a, b, r;
 
@@ -51,7 +51,7 @@ static int ktti_read_regr( PIA *pi, int cont, int regr )
 
 }
 
-static void ktti_read_block( PIA *pi, char * buf, int count )
+static void ktti_read_block(struct pi_adapter *pi, char *buf, int count)
 
 {	int  k, a, b;
 
@@ -64,7 +64,7 @@ static void ktti_read_block( PIA *pi, char * buf, int count )
 	}
 }
 
-static void ktti_write_block( PIA *pi, char * buf, int count )
+static void ktti_write_block(struct pi_adapter *pi, char *buf, int count)
 
 {	int k;
 
@@ -76,21 +76,21 @@ static void ktti_write_block( PIA *pi, char * buf, int count )
 	}
 }
 
-static void ktti_connect ( PIA *pi  )
+static void ktti_connect(struct pi_adapter *pi)
 
 {       pi->saved_r0 = r0();
         pi->saved_r2 = r2();
 	w2(0xb); w2(0xa); w0(0); w2(3); w2(6);	
 }
 
-static void ktti_disconnect ( PIA *pi )
+static void ktti_disconnect(struct pi_adapter *pi)
 
 {       w2(0xb); w2(0xa); w0(0xa0); w2(3); w2(4);
 	w0(pi->saved_r0);
         w2(pi->saved_r2);
 } 
 
-static void ktti_log_adapter( PIA *pi, char * scratch, int verbose )
+static void ktti_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
 
 {
 	printk("ktti %s, KT adapter at 0x%x, delay %d\n",
diff --git a/drivers/ata/pata_parport/on20.c b/drivers/ata/pata_parport/on20.c
index 0a1e60e20656..fb3399329fb6 100644
--- a/drivers/ata/pata_parport/on20.c
+++ b/drivers/ata/pata_parport/on20.c
@@ -33,7 +33,7 @@
    cont = 1 - access the IDE command set 
 */
 
-static int on20_read_regr( PIA *pi, int cont, int regr )
+static int on20_read_regr(struct pi_adapter *pi, int cont, int regr)
 
 {	int h,l, r ;
 
@@ -56,7 +56,7 @@ static int on20_read_regr( PIA *pi, int cont, int regr )
 	return -1;
 }	
 
-static void on20_write_regr( PIA *pi, int cont, int regr, int val )
+static void on20_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
 
 {	int r;
 
@@ -67,7 +67,7 @@ static void on20_write_regr( PIA *pi, int cont, int regr, int val )
 	op(0); vl(val);
 }
 
-static void on20_connect ( PIA *pi)
+static void on20_connect(struct pi_adapter *pi)
 
 {	pi->saved_r0 = r0();
         pi->saved_r2 = r2();
@@ -77,14 +77,14 @@ static void on20_connect ( PIA *pi)
 	       else   { op(2); vl(0); op(2); vl(8); }
 }
 
-static void on20_disconnect ( PIA *pi )
+static void on20_disconnect(struct pi_adapter *pi)
 
 {	w2(4);w0(7);w2(4);w2(0xc);w2(4);
         w0(pi->saved_r0);
         w2(pi->saved_r2);
 } 
 
-static void on20_read_block( PIA *pi, char * buf, int count )
+static void on20_read_block(struct pi_adapter *pi, char *buf, int count)
 
 {	int     k, l, h; 
 
@@ -101,7 +101,7 @@ static void on20_read_block( PIA *pi, char * buf, int count )
 	w2(4);
 }
 
-static void on20_write_block(  PIA *pi, char * buf, int count )
+static void on20_write_block(struct pi_adapter *pi, char *buf, int count)
 
 {	int	k;
 
@@ -111,7 +111,7 @@ static void on20_write_block(  PIA *pi, char * buf, int count )
 	w2(4);
 }
 
-static void on20_log_adapter( PIA *pi, char * scratch, int verbose )
+static void on20_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
 
 {       char    *mode_string[2] = {"4-bit","8-bit"};
 
diff --git a/drivers/ata/pata_parport/on26.c b/drivers/ata/pata_parport/on26.c
index ceb5018caeec..7e5fc499fcc5 100644
--- a/drivers/ata/pata_parport/on26.c
+++ b/drivers/ata/pata_parport/on26.c
@@ -44,7 +44,7 @@
    cont = 1 - access the IDE command set 
 */
 
-static int on26_read_regr( PIA *pi, int cont, int regr )
+static int on26_read_regr(struct pi_adapter *pi, int cont, int regr)
 
 {       int     a, b, r;
 
@@ -73,7 +73,7 @@ static int on26_read_regr( PIA *pi, int cont, int regr )
         return -1;
 }       
 
-static void on26_write_regr( PIA *pi, int cont, int regr, int val )
+static void on26_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
 
 {       int  r;
 
@@ -99,7 +99,7 @@ static void on26_write_regr( PIA *pi, int cont, int regr, int val )
 #define  CCP(x)  w0(0xfe);w0(0xaa);w0(0x55);w0(0);w0(0xff);\
 		 w0(0x87);w0(0x78);w0(x);w2(4);w2(5);w2(4);w0(0xff);
 
-static void on26_connect ( PIA *pi )
+static void on26_connect(struct pi_adapter *pi)
 
 {       int	x;
 
@@ -113,7 +113,7 @@ static void on26_connect ( PIA *pi )
 	w0(2); P1; w0(x); P2;
 }
 
-static void on26_disconnect ( PIA *pi )
+static void on26_disconnect(struct pi_adapter *pi)
 
 {       if (pi->mode >= 2) { w3(4); w3(4); w3(4); w3(4); }
 	              else { w0(4); P1; w0(4); P1; }
@@ -124,7 +124,7 @@ static void on26_disconnect ( PIA *pi )
 
 #define	RESET_WAIT  200
 
-static int on26_test_port( PIA *pi)  /* hard reset */
+static int on26_test_port(struct pi_adapter *pi)  /* hard reset */
 
 {       int     i, m, d, x=0, y=0;
 
@@ -183,7 +183,7 @@ static int on26_test_port( PIA *pi)  /* hard reset */
 }
 
 
-static void on26_read_block( PIA *pi, char * buf, int count )
+static void on26_read_block(struct pi_adapter *pi, char *buf, int count)
 
 {       int     k, a, b;
 
@@ -232,7 +232,7 @@ static void on26_read_block( PIA *pi, char * buf, int count )
         }
 }
 
-static void on26_write_block( PIA *pi, char * buf, int count )
+static void on26_write_block(struct pi_adapter *pi, char *buf, int count)
 
 {       int	k;
 
@@ -275,7 +275,7 @@ static void on26_write_block( PIA *pi, char * buf, int count )
 
 }
 
-static void on26_log_adapter( PIA *pi, char * scratch, int verbose )
+static void on26_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
 
 {       char    *mode_string[5] = {"4-bit","8-bit","EPP-8",
 				   "EPP-16","EPP-32"};
diff --git a/include/linux/pata_parport.h b/include/linux/pata_parport.h
index dcab769aa639..381b4d0e3574 100644
--- a/include/linux/pata_parport.h
+++ b/include/linux/pata_parport.h
@@ -24,8 +24,6 @@ struct pi_adapter {
 	struct pardevice *pardev;	/* pointer to pardevice */
 };
 
-typedef struct pi_adapter PIA;	/* for paride protocol modules */
-
 /* registers are addressed as (cont,regr)
  *	cont: 0 for command register file, 1 for control register(s)
  *	regr: 0-7 for register number.
-- 
Ondrej Zary

