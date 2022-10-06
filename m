Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863C65F70FA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 00:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiJFWJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 18:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiJFWJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:09:15 -0400
Received: from resqmta-h1p-028591.sys.comcast.net (resqmta-h1p-028591.sys.comcast.net [IPv6:2001:558:fd02:2446::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E221B6023
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 15:09:11 -0700 (PDT)
Received: from resomta-h1p-028434.sys.comcast.net ([96.102.179.205])
        by resqmta-h1p-028591.sys.comcast.net with ESMTP
        id gSbFoZoMehQF9gZ3FoMzuc; Thu, 06 Oct 2022 22:09:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1665094149;
        bh=nJYVfPQRVCyawnlOxI56uspahXwrg4Dq4LXXOalzmY8=;
        h=Received:Received:From:To:Subject:Date:Message-Id:MIME-Version;
        b=TpsE5F4ZRex3n13mIWOG7TTpXCCbja9wc22iBiCnGHi7c6idWUS4eaZbSMfDZzWAu
         lXDXw5B719DjZRwvFnPb9hbzStMkeJ1dzub/qGfSTHWDv8iUokQKuSjao5wZb/UCMF
         9yo7HkR2e+g1veaOkqRAtMpd9+vUh35AhkZxvi780FHDLbCljP8AAv4iVmyal45bz1
         Xj04mawxcy8iB4v1iCDSdrUzgrTbuNl83FJG0kzAaWkBwEycWmojFcnXvONIJMkYrF
         rpGB4uc9lEtmhuzuf7wP1+JcnPM3B77JkiHND5ftYebtpQixyHUnhHPgX24lhy0SOQ
         tqrnulfXXzBgA==
Received: from jderrick-mobl4.amr.corp.intel.com ([71.205.181.50])
        by resomta-h1p-028434.sys.comcast.net with ESMTPA
        id gZ2nocknTZjG3gZ2uoEgwz; Thu, 06 Oct 2022 22:08:48 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeiiedgtdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvehomhgtrghsthdqtfgvshhipdfqfgfvpdfpqffurfetoffkrfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhgrthhhrghnucffvghrrhhitghkuceojhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghvqeenucggtffrrghtthgvrhhnpedtteeljeffgfffveehhfetveefuedvheevffffhedtjeeuvdevgfeftddtheeftdenucfkphepjedurddvtdehrddukedurdehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehjuggvrhhrihgtkhdqmhhosghlgedrrghmrhdrtghorhhprdhinhhtvghlrdgtohhmpdhinhgvthepjedurddvtdehrddukedurdehtddpmhgrihhlfhhrohhmpehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvhdpnhgspghrtghpthhtohepiedprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhgrihgusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhonhgrthhhrghnrdguvghrrhhitghkse
 hsohhlihguihhgmhdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhigrdhskhdruggvrhhrihgtkhesihhnthgvlhdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvh
X-Xfinity-VMeta: sc=-100.00;st=legit
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
To:     Song Liu <song@kernel.org>
Cc:     <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        jonathan.derrick@solidigm.com, jonathanx.sk.derrick@intel.com,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: [RFC PATCH] mdadm: Add parameter for bitmap chunk threshold
Date:   Thu,  6 Oct 2022 16:08:38 -0600
Message-Id: <20221006220840.275-2-jonathan.derrick@linux.dev>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221006220840.275-1-jonathan.derrick@linux.dev>
References: <20221006220840.275-1-jonathan.derrick@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds parameter to mdadm create, grow, and build similar to the delay
parameter, that specifies a chunk threshold. This value will instruct
the kernel, in-tandem with the delay timer, to flush the bitmap after
every N chunks have been dirtied. This can be used in-addition to the
delay parameter and complements it.

This requires an addition to the bitmap superblock and version increment.

Usage: -g <Number of chunks, default 0=off>

Signed-off-by: Jonathan Derrick <jonathan.derrick@linux.dev>
---
This RFC patch lacks documentation

 Build.c       |  4 ++--
 Create.c      |  8 ++++----
 Grow.c        |  8 ++++----
 ReadMe.c      | 10 +++++++---
 bitmap.c      |  7 +++++--
 bitmap.h      |  5 ++++-
 config.c      | 16 +++++++++++++++-
 mdadm.c       | 10 ++++++++++
 mdadm.h       |  5 +++--
 super-intel.c |  2 +-
 super0.c      |  3 ++-
 super1.c      |  4 +++-
 12 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/Build.c b/Build.c
index 8d6f6f58..9cdf9616 100644
--- a/Build.c
+++ b/Build.c
@@ -157,7 +157,7 @@ int Build(char *mddev, struct mddev_dev *devlist,
 	if (s->bitmap_file) {
 		bitmap_fd = open(s->bitmap_file, O_RDWR);
 		if (bitmap_fd < 0) {
-			int major = BITMAP_MAJOR_HI;
+			int major = c->threshold ? BITMAP_MAJOR_CHUNKFLUSH : BITMAP_MAJOR_HI;
 #if 0
 			if (s->bitmap_chunk == UnSet) {
 				pr_err("%s cannot be opened.\n", s->bitmap_file);
@@ -166,7 +166,7 @@ int Build(char *mddev, struct mddev_dev *devlist,
 #endif
 			bitmapsize = s->size >> 9; /* FIXME wrong for RAID10 */
 			if (CreateBitmap(s->bitmap_file, 1, NULL,
-					 s->bitmap_chunk, c->delay,
+					 s->bitmap_chunk, c->delay, c->threshold,
 					 s->write_behind, bitmapsize, major)) {
 				goto abort;
 			}
diff --git a/Create.c b/Create.c
index 953e7372..9ef24f82 100644
--- a/Create.c
+++ b/Create.c
@@ -143,7 +143,7 @@ int Create(struct supertype *st, char *mddev,
 	unsigned long long newsize;
 	mdu_array_info_t inf;
 
-	int major_num = BITMAP_MAJOR_HI;
+	int major_num = c->threshold ? BITMAP_MAJOR_CHUNKFLUSH : BITMAP_MAJOR_HI;
 	if (s->bitmap_file && strcmp(s->bitmap_file, "clustered") == 0) {
 		major_num = BITMAP_MAJOR_CLUSTERED;
 		if (c->nodes <= 1) {
@@ -798,8 +798,8 @@ int Create(struct supertype *st, char *mddev,
 				st->ss->name);
 			goto abort_locked;
 		}
-		if (st->ss->add_internal_bitmap(st, &s->bitmap_chunk,
-						c->delay, s->write_behind,
+		if (st->ss->add_internal_bitmap(st, &s->bitmap_chunk, c->delay,
+						c->threshold, s->write_behind,
 						bitmapsize, 1, major_num)) {
 			pr_err("Given bitmap chunk size not supported.\n");
 			goto abort_locked;
@@ -852,7 +852,7 @@ int Create(struct supertype *st, char *mddev,
 
 		st->ss->uuid_from_super(st, uuid);
 		if (CreateBitmap(s->bitmap_file, c->force, (char*)uuid, s->bitmap_chunk,
-				 c->delay, s->write_behind,
+				 c->delay, c->threshold, s->write_behind,
 				 bitmapsize,
 				 major_num)) {
 			goto abort_locked;
diff --git a/Grow.c b/Grow.c
index e362403a..5ae91138 100644
--- a/Grow.c
+++ b/Grow.c
@@ -287,7 +287,7 @@ int Grow_addbitmap(char *devname, int fd, struct context *c, struct shape *s)
 	mdu_array_info_t array;
 	struct supertype *st;
 	char *subarray = NULL;
-	int major = BITMAP_MAJOR_HI;
+	int major = c->threshold ? BITMAP_MAJOR_CHUNKFLUSH : BITMAP_MAJOR_HI;
 	unsigned long long bitmapsize, array_size;
 	struct mdinfo *mdi;
 
@@ -441,7 +441,7 @@ int Grow_addbitmap(char *devname, int fd, struct context *c, struct shape *s)
 			if (!rv) {
 				rv = st->ss->add_internal_bitmap(
 					st, &s->bitmap_chunk, c->delay,
-					s->write_behind, bitmapsize,
+					c->threshold, s->write_behind, bitmapsize,
 					offset_setable, major);
 				if (!rv) {
 					st->ss->write_bitmap(st, fd2,
@@ -512,8 +512,8 @@ int Grow_addbitmap(char *devname, int fd, struct context *c, struct shape *s)
 			return 1;
 		}
 		if (CreateBitmap(s->bitmap_file, c->force, (char*)uuid,
-				 s->bitmap_chunk, c->delay, s->write_behind,
-				 bitmapsize, major)) {
+				 s->bitmap_chunk, c->delay, c->threshold,
+				 s->write_behind, bitmapsize, major)) {
 			return 1;
 		}
 		bitmap_fd = open(s->bitmap_file, O_RDWR);
diff --git a/ReadMe.c b/ReadMe.c
index 50a5e36d..87ef4b42 100644
--- a/ReadMe.c
+++ b/ReadMe.c
@@ -81,12 +81,12 @@ char Version[] = "mdadm - v" VERSION " - " VERS_DATE EXTRAVERSION "\n";
  *     found, it is started.
  */
 
-char short_options[]="-ABCDEFGIQhVXYWZ:vqbc:i:l:p:m:n:x:u:c:d:z:U:N:sarfRSow1tye:k:";
+char short_options[]="-ABCDEFGIQhVXYWZ:vqbc:g:i:l:p:m:n:x:u:c:d:z:U:N:sarfRSow1tye:k:";
 char short_monitor_options[]="-ABCDEFGIQhVXYWZ:vqbc:i:l:p:m:r:n:x:u:c:d:z:U:N:safRSow1tye:k:";
 char short_bitmap_options[]=
-		"-ABCDEFGIQhVXYWZ:vqb:c:i:l:p:m:n:x:u:c:d:z:U:N:sarfRSow1tye:k:";
+		"-ABCDEFGIQhVXYWZ:vqb:c:g:i:l:p:m:n:x:u:c:d:z:U:N:sarfRSow1tye:k:";
 char short_bitmap_auto_options[]=
-		"-ABCDEFGIQhVXYWZ:vqb:c:i:l:p:m:n:x:u:c:d:z:U:N:sa:rfRSow1tye:k:";
+		"-ABCDEFGIQhVXYWZ:vqb:c:g:i:l:p:m:n:x:u:c:d:z:U:N:sa:rfRSow1tye:k:";
 
 struct option long_options[] = {
     {"manage",    0, 0, ManageOpt},
@@ -196,6 +196,7 @@ struct option long_options[] = {
     {"alert",     1, 0, ProgramOpt},
     {"increment", 1, 0, Increment},
     {"delay",     1, 0, 'd'},
+    {"threshold", 1, 0, 'g'},
     {"daemonise", 0, 0, Fork},
     {"daemonize", 0, 0, Fork},
     {"oneshot",   0, 0, '1'},
@@ -304,6 +305,7 @@ char OptionHelp[] =
 "  --assume-clean     : Assume the array is already in-sync. This is dangerous for RAID5.\n"
 "  --bitmap-chunk=    : chunksize of bitmap in bitmap file (Kilobytes)\n"
 "  --delay=      -d   : seconds between bitmap updates\n"
+"  --threshold=  -g   : chunks between bitmap updates\n"
 "  --write-behind=    : number of simultaneous write-behind requests to allow (requires bitmap)\n"
 "  --name=       -N   : Textual name for array - max 32 characters\n"
 "\n"
@@ -387,6 +389,7 @@ char Help_create[] =
 "  --name=            -N : Textual name for array - max 32 characters\n"
 "  --bitmap-chunk=       : bitmap chunksize in Kilobytes.\n"
 "  --delay=           -d : bitmap update delay in seconds.\n"
+"  --threshold=       -g : chunks between bitmap updates.\n"
 "  --write-journal=      : Specify journal device for RAID-4/5/6 array\n"
 "  --consistency-policy= : Specify the policy that determines how the array\n"
 "                     -k : maintains consistency in case of unexpected shutdown.\n"
@@ -412,6 +415,7 @@ char Help_build[] =
 "  --raid-devices= -n : number of active devices in array\n"
 "  --bitmap-chunk=    : bitmap chunksize in Kilobytes.\n"
 "  --delay=      -d   : bitmap update delay in seconds.\n"
+"  --threshold=  -g   : chunks between bitmap updates\n"
 ;
 
 char Help_assemble[] =
diff --git a/bitmap.c b/bitmap.c
index 9a7ffe3b..0dfdb9c7 100644
--- a/bitmap.c
+++ b/bitmap.c
@@ -33,6 +33,7 @@ static inline void sb_le_to_cpu(bitmap_super_t *sb)
 	sb->sync_size = __le64_to_cpu(sb->sync_size);
 	sb->write_behind = __le32_to_cpu(sb->write_behind);
 	sb->nodes = __le32_to_cpu(sb->nodes);
+	sb->daemon_flush_chunks = __le32_to_cpu(sb->daemon_flush_chunks);
 	sb->sectors_reserved = __le32_to_cpu(sb->sectors_reserved);
 }
 
@@ -273,7 +274,7 @@ int ExamineBitmap(char *filename, int brief, struct supertype *st)
 	}
 	printf("         Version : %d\n", sb->version);
 	if (sb->version < BITMAP_MAJOR_LO ||
-	    sb->version > BITMAP_MAJOR_CLUSTERED) {
+	    sb->version > BITMAP_MAJOR_CHUNKFLUSH) {
 		pr_err("unknown bitmap version %d, either the bitmap file\n",
 		       sb->version);
 		pr_err("is corrupted or you need to upgrade your tools\n");
@@ -311,7 +312,7 @@ int ExamineBitmap(char *filename, int brief, struct supertype *st)
 	}
 
 	printf("       Chunksize : %s\n", human_chunksize(sb->chunksize));
-	printf("          Daemon : %ds flush period\n", sb->daemon_sleep);
+	printf("          Daemon : %ds flush period, %d chunks\n", sb->daemon_sleep, sb->daemon_flush_chunks);
 	if (sb->write_behind)
 		sprintf(buf, "Allow write behind, max %d", sb->write_behind);
 	else
@@ -427,6 +428,7 @@ out:
 
 int CreateBitmap(char *filename, int force, char uuid[16],
 		 unsigned long chunksize, unsigned long daemon_sleep,
+		 unsigned int daemon_flush_chunks,
 		 unsigned long write_behind,
 		 unsigned long long array_size /* sectors */,
 		 int major)
@@ -472,6 +474,7 @@ int CreateBitmap(char *filename, int force, char uuid[16],
 		memcpy(sb.uuid, uuid, 16);
 	sb.chunksize = chunksize;
 	sb.daemon_sleep = daemon_sleep;
+	sb.daemon_flush_chunks = daemon_flush_chunks;
 	sb.write_behind = write_behind;
 	sb.sync_size = array_size;
 
diff --git a/bitmap.h b/bitmap.h
index 7b1f80f2..48ebc0b9 100644
--- a/bitmap.h
+++ b/bitmap.h
@@ -9,10 +9,12 @@
 #define BITMAP_MAJOR_LO 3
 /* version 4 insists the bitmap is in little-endian order
  * with version 3, it is host-endian which is non-portable
+ * Version 6 supports the flush-chunks threshold
  */
 #define BITMAP_MAJOR_HI 4
 #define	BITMAP_MAJOR_HOSTENDIAN 3
 #define	BITMAP_MAJOR_CLUSTERED 5
+#define	BITMAP_MAJOR_CHUNKFLUSH 6
 
 #define BITMAP_MINOR 39
 
@@ -159,7 +161,8 @@ typedef struct bitmap_super_s {
 				 * reserved for the bitmap. */
 	__u32 nodes;        /* 68 the maximum number of nodes in cluster. */
 	__u8 cluster_name[64]; /* 72 cluster name to which this md belongs */
-	__u8  pad[256 - 136]; /* set to zero */
+	__u32 daemon_flush_chunks; /* 136 dirty chunks between flushes */
+	__u8  pad[256 - 140]; /* set to zero */
 } bitmap_super_t;
 
 /* notes:
diff --git a/config.c b/config.c
index dc1620c1..744d5d4f 100644
--- a/config.c
+++ b/config.c
@@ -81,7 +81,7 @@ char DefaultAltConfDir[] = CONFFILE2 ".d";
 
 enum linetype { Devices, Array, Mailaddr, Mailfrom, Program, CreateDev,
 		Homehost, HomeCluster, AutoMode, Policy, PartPolicy, Sysfs,
-		MonitorDelay, LTEnd };
+		MonitorDelay, Threshold, LTEnd };
 char *keywords[] = {
 	[Devices]  = "devices",
 	[Array]    = "array",
@@ -96,6 +96,7 @@ char *keywords[] = {
 	[PartPolicy]="part-policy",
 	[Sysfs]    = "sysfs",
 	[MonitorDelay] = "monitordelay",
+	[Threshold] = "threshold",
 	[LTEnd]    = NULL
 };
 
@@ -595,6 +596,17 @@ void monitordelayline(char *line)
 	}
 }
 
+static int threshold;
+void thresholdline(char *line)
+{
+	char *w;
+
+	for (w = dl_next(line); w != line; w = dl_next(w)) {
+		if (threshold == 0)
+			threshold = strtol(w, NULL, 10);
+	}
+}
+
 char auto_yes[] = "yes";
 char auto_no[] = "no";
 char auto_homehost[] = "homehost";
@@ -779,6 +791,8 @@ void conf_file(FILE *f)
 		case MonitorDelay:
 			monitordelayline(line);
 			break;
+		case Threshold:
+			thresholdline(line);
 		default:
 			pr_err("Unknown keyword %s\n", line);
 		}
diff --git a/mdadm.c b/mdadm.c
index 972adb52..72c12406 100644
--- a/mdadm.c
+++ b/mdadm.c
@@ -912,6 +912,16 @@ int main(int argc, char *argv[])
 				exit(2);
 			}
 			continue;
+		case O(GROW, 'g'):
+		case O(BUILD,'g'): /* flush chunk threshold for bitmap updates */
+		case O(CREATE,'g'):
+			if (c.threshold)
+				pr_err("only specify threshold once. %s ignored.\n", optarg);
+			else if (parse_num(&c.threshold, optarg) != 0) {
+				pr_err("invalid threshold: %s\n", optarg);
+				exit(2);
+			}
+			continue;
 		case O(MONITOR,'f'): /* daemonise */
 		case O(MONITOR,Fork):
 			daemonise = 1;
diff --git a/mdadm.h b/mdadm.h
index 3673494e..d135a55a 100644
--- a/mdadm.h
+++ b/mdadm.h
@@ -574,6 +574,7 @@ struct context {
 	int	SparcAdjust;
 	int	autof;
 	int	delay;
+	int	threshold;
 	int	freeze_reshape;
 	char	*backup_file;
 	int	invalid_backup;
@@ -1043,7 +1044,7 @@ extern struct superswitch {
 	 * -Exxxx: On error
 	 */
 	int (*add_internal_bitmap)(struct supertype *st, int *chunkp,
-				   int delay, int write_behind,
+				   int delay, int threshold, int write_behind,
 				   unsigned long long size, int may_change, int major);
 	/* Perform additional setup required to activate a bitmap.
 	 */
@@ -1491,7 +1492,7 @@ extern int IncrementalScan(struct context *c, char *devnm);
 extern int IncrementalRemove(char *devname, char *path, int verbose);
 extern int CreateBitmap(char *filename, int force, char uuid[16],
 			unsigned long chunksize, unsigned long daemon_sleep,
-			unsigned long write_behind,
+			unsigned int daemon_flush_chunks, unsigned long write_behind,
 			unsigned long long array_size,
 			int major);
 extern int ExamineBitmap(char *filename, int brief, struct supertype *st);
diff --git a/super-intel.c b/super-intel.c
index b0565610..aadccdda 100644
--- a/super-intel.c
+++ b/super-intel.c
@@ -12645,7 +12645,7 @@ static int validate_internal_bitmap_imsm(struct supertype *st)
  *	-1 : fail
  ******************************************************************************/
 static int add_internal_bitmap_imsm(struct supertype *st, int *chunkp,
-				    int delay, int write_behind,
+				    int delay, int threshold, int write_behind,
 				    unsigned long long size, int may_change,
 				    int amajor)
 {
diff --git a/super0.c b/super0.c
index 93876e2e..369a870d 100644
--- a/super0.c
+++ b/super0.c
@@ -1123,7 +1123,7 @@ static __u64 avail_size0(struct supertype *st, __u64 devsize,
 }
 
 static int add_internal_bitmap0(struct supertype *st, int *chunkp,
-				int delay, int write_behind,
+				int delay, int threshold, int write_behind,
 				unsigned long long size, int may_change,
 				int major)
 {
@@ -1166,6 +1166,7 @@ static int add_internal_bitmap0(struct supertype *st, int *chunkp,
 	memcpy(bms->uuid, uuid, 16);
 	bms->chunksize = __cpu_to_le32(chunk);
 	bms->daemon_sleep = __cpu_to_le32(delay);
+	bms->daemon_flush_chunks = __cpu_to_le32(threshold);
 	bms->sync_size = __cpu_to_le64(size);
 	bms->write_behind = __cpu_to_le32(write_behind);
 	*chunkp = chunk;
diff --git a/super1.c b/super1.c
index 0b505a7e..67068e02 100644
--- a/super1.c
+++ b/super1.c
@@ -2466,7 +2466,8 @@ static __u64 avail_size1(struct supertype *st, __u64 devsize,
 
 static int
 add_internal_bitmap1(struct supertype *st,
-		     int *chunkp, int delay, int write_behind,
+		     int *chunkp, int delay,
+		     int threshold, int write_behind,
 		     unsigned long long size,
 		     int may_change, int major)
 {
@@ -2615,6 +2616,7 @@ add_internal_bitmap1(struct supertype *st,
 	memcpy(bms->uuid, uuid, 16);
 	bms->chunksize = __cpu_to_le32(chunk);
 	bms->daemon_sleep = __cpu_to_le32(delay);
+	bms->daemon_flush_chunks = __cpu_to_le32(threshold);
 	bms->sync_size = __cpu_to_le64(size);
 	bms->write_behind = __cpu_to_le32(write_behind);
 	bms->nodes = __cpu_to_le32(st->nodes);
-- 
2.31.1

