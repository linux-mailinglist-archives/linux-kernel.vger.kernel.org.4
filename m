Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208D1745CB7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjGCNAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjGCNAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:00:17 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155CDC7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 06:00:16 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc244d384so40719905e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 06:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688389214; x=1690981214;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M3dY32YJdb0J4v2AuSDueYcxVXmppCxt2qe2TyAIO3o=;
        b=MQZ8h8b6MjG0SyuJltC9tce3fzjsrYF/2AMHoieVP29eU51GfZwk/rmJLhIn0kvPN+
         QSSZ6BPCl04Xd5YBx9+RXSsDm2NX7lzZMHq8DsrfbxkYTVLBnTwhEGcmaELuFsBDUkAz
         pqQdhPnePu+2ld+fhFbASxDSLh6fNRttzSC4dVII/2xnI0UxSOcef1+SoKBASDfrBsSL
         reIFn0mT0tGVxVmuzMPFstrE+TF+Wi6ub6SqBwnhq9xbfZ9GFDA/8/syWgL1onZVGi6u
         4fC+nUl80JtSiwO1Nq3cqE2RyN6oTqiC44Qp7Tib35kDDKKB4BREhQY2AJhBWcH/LlH1
         e+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688389214; x=1690981214;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M3dY32YJdb0J4v2AuSDueYcxVXmppCxt2qe2TyAIO3o=;
        b=TbSY1lT1XqONJpFfVn7XsUq3cWe4iw/BJJW0X3K7a+ljJbQoJ+S+Bq3r2xT0xRDU7d
         zYHItsRGltcONH6pSDT6X3ztwUhX6frFNxWUpeeczp/kxgLuUFdJYnz1GA3BMq0WDMpE
         W+1+mhMC1nSmbDX+3zYoBDUUDebIzNjwPcHgkK5O1kVNtDroGXEnf5b5pis69cdocQwq
         onH+8wWxQV11YrDc14q7ae3Atexrp4EF9zIIid4mcTSwVisXtRFjXfEjyb/4xde2VVd8
         +BS4KySVpWMJwTMG+m2cI2oKI8osPdgWHCfxIhf4eAjEDBWfA8YgcDG27/4xNYmWgS2e
         LyaA==
X-Gm-Message-State: AC+VfDz3NiuVE/FYx85Sr3L8TA3xjQEaPtNYKgQLt/7GgGYcces1HwkX
        WtULSRTugohPIYQIfNWpwY80GA==
X-Google-Smtp-Source: ACHHUZ5MucnkBiYH+4dn5QH+ikSD6oOLJ3aNIEMsnuFc5fLEPobSu2rYMasE/30Qs0HcY1/DwwJQZA==
X-Received: by 2002:a7b:cb9a:0:b0:3fa:9590:a365 with SMTP id m26-20020a7bcb9a000000b003fa9590a365mr7393073wmi.17.1688389214454;
        Mon, 03 Jul 2023 06:00:14 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c314900b003fa9a00d74csm8594808wmo.3.2023.07.03.06.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 06:00:11 -0700 (PDT)
Date:   Mon, 3 Jul 2023 16:00:01 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: sound/firewire/amdtp-stream.c:1099 process_rx_packets() error:
 uninitialized symbol 'curr_cycle_time'.
Message-ID: <bacd122c-175c-4fe8-bc6a-66de5820eed0@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b25f62ccb490680a8cee755ac4528909395e0711
commit: fef4e61b0b765b6d22badcd5b6575b159e7d510a ALSA: firewire-lib: extend tracepoints event including CYCLE_TIME of 1394 OHCI
config: i386-randconfig-m021-20230701 (https://download.01.org/0day-ci/archive/20230701/202307011324.jFJ96dTo-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230701/202307011324.jFJ96dTo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202307011324.jFJ96dTo-lkp@intel.com/

New smatch warnings:
sound/firewire/amdtp-stream.c:1099 process_rx_packets() error: uninitialized symbol 'curr_cycle_time'.

Old smatch warnings:
sound/firewire/amdtp-stream.c:944 generate_tx_packet_descs() error: uninitialized symbol 'curr_cycle_time'.

vim +/curr_cycle_time +1099 sound/firewire/amdtp-stream.c

9b1fcd9bf80206 sound/firewire/amdtp-stream.c Takashi Sakamoto 2021-05-20  1047  static void process_rx_packets(struct fw_iso_context *context, u32 tstamp, size_t header_length,
9b1fcd9bf80206 sound/firewire/amdtp-stream.c Takashi Sakamoto 2021-05-20  1048  			       void *header, void *private_data)
0f5cfcb24d9c93 sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-07-22  1049  {
0f5cfcb24d9c93 sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-07-22  1050  	struct amdtp_stream *s = private_data;
69efd5c4bd4c0e sound/firewire/amdtp-stream.c Takashi Sakamoto 2020-05-08  1051  	const struct amdtp_domain *d = s->domain;
0f5cfcb24d9c93 sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-07-22  1052  	const __be32 *ctx_header = header;
9b1fcd9bf80206 sound/firewire/amdtp-stream.c Takashi Sakamoto 2021-05-20  1053  	const unsigned int events_per_period = d->events_per_period;
60dd49298ec580 sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-10-18  1054  	unsigned int event_count = s->ctx_data.rx.event_count;
f0117128879be6 sound/firewire/amdtp-stream.c Takashi Sakamoto 2023-01-09  1055  	struct pkt_desc *desc = s->packet_descs_cursor;
233dbbc7af5d27 sound/firewire/amdtp-stream.c Takashi Sakamoto 2021-05-20  1056  	unsigned int pkt_header_length;
a0e023317e2d55 sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-10-18  1057  	unsigned int packets;
fef4e61b0b765b sound/firewire/amdtp-stream.c Takashi Sakamoto 2023-01-10  1058  	u32 curr_cycle_time;
d360870a5bcff7 sound/firewire/amdtp-stream.c Takashi Sakamoto 2021-05-27  1059  	bool need_hw_irq;
0f5cfcb24d9c93 sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-07-22  1060  	int i;
0f5cfcb24d9c93 sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-07-22  1061  
0f5cfcb24d9c93 sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-07-22  1062  	if (s->packet_index < 0)
0f5cfcb24d9c93 sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-07-22  1063  		return;
0f5cfcb24d9c93 sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-07-22  1064  
a0e023317e2d55 sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-10-18  1065  	// Calculate the number of packets in buffer and check XRUN.
a0e023317e2d55 sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-10-18  1066  	packets = header_length / sizeof(*ctx_header);
a0e023317e2d55 sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-10-18  1067  
cec371ff1ab18d sound/firewire/amdtp-stream.c Takashi Sakamoto 2023-01-09  1068  	generate_rx_packet_descs(s, desc, ctx_header, packets);
0f5cfcb24d9c93 sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-07-22  1069  
cec371ff1ab18d sound/firewire/amdtp-stream.c Takashi Sakamoto 2023-01-09  1070  	process_ctx_payloads(s, desc, packets);
5e2ece0fdceb02 sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-07-22  1071  
233dbbc7af5d27 sound/firewire/amdtp-stream.c Takashi Sakamoto 2021-05-20  1072  	if (!(s->flags & CIP_NO_HEADER))
233dbbc7af5d27 sound/firewire/amdtp-stream.c Takashi Sakamoto 2021-05-20  1073  		pkt_header_length = IT_PKT_HEADER_SIZE_CIP;
233dbbc7af5d27 sound/firewire/amdtp-stream.c Takashi Sakamoto 2021-05-20  1074  	else
233dbbc7af5d27 sound/firewire/amdtp-stream.c Takashi Sakamoto 2021-05-20  1075  		pkt_header_length = 0;
233dbbc7af5d27 sound/firewire/amdtp-stream.c Takashi Sakamoto 2021-05-20  1076  
d360870a5bcff7 sound/firewire/amdtp-stream.c Takashi Sakamoto 2021-05-27  1077  	if (s == d->irq_target) {
d360870a5bcff7 sound/firewire/amdtp-stream.c Takashi Sakamoto 2021-05-27  1078  		// At NO_PERIOD_WAKEUP mode, the packets for all IT/IR contexts are processed by
d360870a5bcff7 sound/firewire/amdtp-stream.c Takashi Sakamoto 2021-05-27  1079  		// the tasks of user process operating ALSA PCM character device by calling ioctl(2)
d360870a5bcff7 sound/firewire/amdtp-stream.c Takashi Sakamoto 2021-05-27  1080  		// with some requests, instead of scheduled hardware IRQ of an IT context.
d360870a5bcff7 sound/firewire/amdtp-stream.c Takashi Sakamoto 2021-05-27  1081  		struct snd_pcm_substream *pcm = READ_ONCE(s->pcm);
d360870a5bcff7 sound/firewire/amdtp-stream.c Takashi Sakamoto 2021-05-27  1082  		need_hw_irq = !pcm || !pcm->runtime->no_period_wakeup;
d360870a5bcff7 sound/firewire/amdtp-stream.c Takashi Sakamoto 2021-05-27  1083  	} else {
d360870a5bcff7 sound/firewire/amdtp-stream.c Takashi Sakamoto 2021-05-27  1084  		need_hw_irq = false;
d360870a5bcff7 sound/firewire/amdtp-stream.c Takashi Sakamoto 2021-05-27  1085  	}
d360870a5bcff7 sound/firewire/amdtp-stream.c Takashi Sakamoto 2021-05-27  1086  
fef4e61b0b765b sound/firewire/amdtp-stream.c Takashi Sakamoto 2023-01-10  1087  	if (trace_amdtp_packet_enabled())
fef4e61b0b765b sound/firewire/amdtp-stream.c Takashi Sakamoto 2023-01-10  1088  		(void)fw_card_read_cycle_time(fw_parent_device(s->unit)->card, &curr_cycle_time);

If trace_amdtp_packet_enabled() is false then curr_cycle_time is
uninitialized.

fef4e61b0b765b sound/firewire/amdtp-stream.c Takashi Sakamoto 2023-01-10  1089  
5e2ece0fdceb02 sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-07-22  1090  	for (i = 0; i < packets; ++i) {
6bc1a2699b79d7 sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-05-24  1091  		struct {
6bc1a2699b79d7 sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-05-24  1092  			struct fw_iso_packet params;
67d92ee7a50b00 sound/firewire/amdtp-stream.c Takashi Sakamoto 2021-05-20  1093  			__be32 header[CIP_HEADER_QUADLETS];
6bc1a2699b79d7 sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-05-24  1094  		} template = { {0}, {0} };
e229853d505d7a sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-10-18  1095  		bool sched_irq = false;
6bc1a2699b79d7 sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-05-24  1096  
233dbbc7af5d27 sound/firewire/amdtp-stream.c Takashi Sakamoto 2021-05-20  1097  		build_it_pkt_header(s, desc->cycle, &template.params, pkt_header_length,
f4f6ae7b7c1fdb sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-07-22  1098  				    desc->data_blocks, desc->data_block_counter,
fef4e61b0b765b sound/firewire/amdtp-stream.c Takashi Sakamoto 2023-01-10 @1099  				    desc->syt, i, curr_cycle_time);

The curr_cycle_time variable is only going to be used if trace_amdtp_packet_enabled()
is true.  We would consider it a false positive if build_it_pkt_header()
is inlined but a bug if it's not.  (Technically passing uninitialized
data is undefined behavior but if a function is inlined then it's not
"passing" anything).

31ef9134eb5263 sound/firewire/amdtp.c        Clemens Ladisch  2011-03-15  1100  
2472cfb3232caf sound/firewire/amdtp-stream.c Takashi Sakamoto 2020-05-08  1101  		if (s == s->domain->irq_target) {
e229853d505d7a sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-10-18  1102  			event_count += desc->data_blocks;
e229853d505d7a sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-10-18  1103  			if (event_count >= events_per_period) {
e229853d505d7a sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-10-18  1104  				event_count -= events_per_period;
d360870a5bcff7 sound/firewire/amdtp-stream.c Takashi Sakamoto 2021-05-27  1105  				sched_irq = need_hw_irq;
e229853d505d7a sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-10-18  1106  			}
60dd49298ec580 sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-10-18  1107  		}
e229853d505d7a sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-10-18  1108  
e229853d505d7a sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-10-18  1109  		if (queue_out_packet(s, &template.params, sched_irq) < 0) {
fce9b013fee94d sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-05-21  1110  			cancel_stream(s);
a4103bd7fdd595 sound/firewire/amdtp.c        Takashi Sakamoto 2015-05-22  1111  			return;
ccccad8646fad5 sound/firewire/amdtp.c        Takashi Sakamoto 2014-04-25  1112  		}
cec371ff1ab18d sound/firewire/amdtp-stream.c Takashi Sakamoto 2023-01-09  1113  
cec371ff1ab18d sound/firewire/amdtp-stream.c Takashi Sakamoto 2023-01-09  1114  		desc = amdtp_stream_next_packet_desc(s, desc);
a4103bd7fdd595 sound/firewire/amdtp.c        Takashi Sakamoto 2015-05-22  1115  	}
a4103bd7fdd595 sound/firewire/amdtp.c        Takashi Sakamoto 2015-05-22  1116  
60dd49298ec580 sound/firewire/amdtp-stream.c Takashi Sakamoto 2019-10-18  1117  	s->ctx_data.rx.event_count = event_count;
f0117128879be6 sound/firewire/amdtp-stream.c Takashi Sakamoto 2023-01-09  1118  	s->packet_descs_cursor = desc;
31ef9134eb5263 sound/firewire/amdtp.c        Clemens Ladisch  2011-03-15  1119  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

