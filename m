Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124E062DD42
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239352AbiKQNwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239529AbiKQNwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:52:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3584045A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668693095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L00VubbecULr+E/4rDi9NiXWg4TT9LuGtAi5kWcoAGw=;
        b=S79wWUFjF3nKbRosvBDEKnHBG6Kr2CH4L8/mK8GxDS1q9NDNu0QdPavpYsvGj+9ozHpkho
        Gjt51qOTmjhau8Jys5S+DN+nmUNTyBRk6/hKFAcg8/CTVultJ/p/Tw/JElO0c7fo3R4ozu
        PETDYIFIOwI02UlZXQBqnyzPvjFo7Xg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-231-C2ZybG9gP8Kq0Ww1fzPlag-1; Thu, 17 Nov 2022 08:51:33 -0500
X-MC-Unique: C2ZybG9gP8Kq0Ww1fzPlag-1
Received: by mail-ed1-f69.google.com with SMTP id x18-20020a05640226d200b00461e027f704so1264450edd.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:51:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L00VubbecULr+E/4rDi9NiXWg4TT9LuGtAi5kWcoAGw=;
        b=jIxCN2JaJlEMZlVlJVSKWQTaJ8DssqJU4+PLnfufdUtC4tPYIyo4v3igMFw/m41NLh
         U0Ehq3YB9gEYwCec3DBSP/zEljcZs+S0cZCxAskU4XrcWePRo6hpy2fZp4gSRFfKlwx8
         j5ZaK60PxIy2Zajz2/j/4mgQEU5tt/LaZzc4nK698SLAxEVlV681AFwLGBGr1GPZ2ecJ
         Oe05pGR5me2XjrWt7xDnvj/90JHJYapnKb4IHX9LGg7wOCARX46+ZLisnO+Ezb3lvxwm
         0hjf99F7csix7yoxE1qE8rx1J4CFo4tYzFPAj7xnyTLO14jqpxM3C8rcbgfIjwL1i98/
         3yzg==
X-Gm-Message-State: ANoB5pmgV/3KdD8oDwBzlVLpMDokNZimXESn+6IcFRAPWeSNKYyyRvMs
        I+hFbPIEVsYQV8vFIUY19/K61nzJ+o2XTgAjgxAz2qRDQ0OgDBhcIMiB9UkWpUlF4a0/Nr/sDRH
        I20jcmvNBuEB2RUd6eGKB/Ut8
X-Received: by 2002:a05:6402:1399:b0:461:53b0:2ac0 with SMTP id b25-20020a056402139900b0046153b02ac0mr2158936edv.153.1668693092289;
        Thu, 17 Nov 2022 05:51:32 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7KgSe4Pb1xYyUTs5UMBYmDPUGi91g1L/sIyCif1/EVnl9jKk/Cm+efdBIEckqjAjGCxA/zBw==
X-Received: by 2002:a05:6402:1399:b0:461:53b0:2ac0 with SMTP id b25-20020a056402139900b0046153b02ac0mr2158921edv.153.1668693092057;
        Thu, 17 Nov 2022 05:51:32 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id g2-20020a056402428200b0046146c730easm553765edc.75.2022.11.17.05.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 05:51:31 -0800 (PST)
Message-ID: <77a419c3-971c-3836-b49e-e950e574c740@redhat.com>
Date:   Thu, 17 Nov 2022 14:51:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 5/9] tools/arch/x86: intel_sdsi: Add support for reading
 state certificates
Content-Language: en-US, nl
To:     "David E. Box" <david.e.box@linux.intel.com>, markgross@kernel.org,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221101191023.4150315-1-david.e.box@linux.intel.com>
 <20221101191023.4150315-6-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221101191023.4150315-6-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/1/22 20:10, David E. Box wrote:
> Add option to read and decode On Demand state certificates.
> 
> Link: https://github.com/intel/intel-sdsi/blob/master/state-certificate-encoding.rst
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  tools/arch/x86/intel_sdsi/intel_sdsi.c | 268 ++++++++++++++++++-------
>  1 file changed, 198 insertions(+), 70 deletions(-)
> 
> diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> index c0e2f2349db4..9dd94014a672 100644
> --- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
> +++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> @@ -22,11 +22,24 @@
>  
>  #include <sys/types.h>
>  
> +#ifndef __packed
> +#define __packed __attribute__((packed))
> +#endif
> +
> +#define min(x, y) ({                            \
> +	typeof(x) _min1 = (x);                  \
> +	typeof(y) _min2 = (y);                  \
> +	(void) (&_min1 == &_min2);              \
> +	_min1 < _min2 ? _min1 : _min2; })
> +
>  #define SDSI_DEV		"intel_vsec.sdsi"
>  #define AUX_DEV_PATH		"/sys/bus/auxiliary/devices/"
>  #define SDSI_PATH		(AUX_DEV_DIR SDSI_DEV)
>  #define GUID			0x6dd191
>  #define REGISTERS_MIN_SIZE	72
> +#define STATE_CERT_MAX_SIZE	4096
> +#define STATE_MAX_NUM_LICENSES	16
> +#define STATE_MAX_NUM_IN_BUNDLE	(uint32_t)8
>  
>  #define __round_mask(x, y) ((__typeof__(x))((y) - 1))
>  #define round_up(x, y) ((((x) - 1) | __round_mask(x, y)) + 1)
> @@ -49,6 +62,7 @@ struct availability {
>  	uint64_t reserved:48;
>  	uint64_t available:3;
>  	uint64_t threshold:3;
> +	uint64_t reserved2:10;
>  };
>  
>  struct sdsi_regs {
> @@ -63,17 +77,55 @@ struct sdsi_regs {
>  	uint64_t socket_id;
>  };
>  
> +#define CONTENT_TYPE_LK_ENC		0xD
> +#define CONTENT_TYPE_LK_BLOB_ENC	0xE
> +
> +struct state_certificate {
> +	uint32_t content_type;
> +	uint32_t region_rev_id;
> +	uint32_t header_size;
> +	uint32_t total_size;
> +	uint32_t key_size;
> +	uint32_t num_licenses;
> +};
> +
> +struct license_key_info {
> +	uint32_t key_rev_id;
> +	uint64_t key_image_content[6];
> +} __packed;
> +
> +#define LICENSE_BLOB_SIZE(l)	(((l) & 0x7fffffff) * 4)
> +#define LICENSE_VALID(l)	(!!((l) & 0x80000000))
> +
> +// License Group Types
> +#define LBT_ONE_TIME_UPGRADE	1
> +#define LBT_METERED_UPGRADE	2
> +
> +struct license_blob_content {
> +	uint32_t type;
> +	uint64_t id;
> +	uint64_t ppin;
> +	uint64_t previous_ppin;
> +	uint32_t rev_id;
> +	uint32_t num_bundles;
> +} __packed;
> +
> +struct bundle_encoding {
> +	uint32_t encoding;
> +	uint32_t encoding_rsvd[7];
> +};
> +
>  struct sdsi_dev {
>  	struct sdsi_regs regs;
> +	struct state_certificate sc;
>  	char *dev_name;
>  	char *dev_path;
>  	int guid;
>  };
>  
>  enum command {
> -	CMD_NONE,
>  	CMD_SOCKET_INFO,
> -	CMD_DUMP_CERT,
> +	CMD_STATE_CERT,
>  	CMD_PROV_AKC,
>  	CMD_PROV_CAP,
>  };
> @@ -168,20 +220,56 @@ static int sdsi_read_reg(struct sdsi_dev *s)
>  	return 0;
>  }
>  
> -static int sdsi_certificate_dump(struct sdsi_dev *s)
> +static char *license_blob_type(uint32_t type)
> +{
> +	switch (type) {
> +	case LBT_ONE_TIME_UPGRADE:
> +		return "One time upgrade";
> +	case LBT_METERED_UPGRADE:
> +		return "Metered upgrade";
> +	default:
> +		return "Unknown license blob type";
> +	}
> +}
> +
> +static char *content_type(uint32_t type)
> +{
> +	switch (type) {
> +	case  CONTENT_TYPE_LK_ENC:
> +		return "Licencse key encoding";
> +	case CONTENT_TYPE_LK_BLOB_ENC:
> +		return "License key + Blob encoding";
> +	default:
> +		return "Unknown content type";
> +	}
> +}
> +
> +static void get_feature(uint32_t encoding, char *feature)
> +{
> +	char *name = (char *)&encoding;
> +
> +	feature[3] = name[0];
> +	feature[2] = name[1];
> +	feature[1] = name[2];
> +	feature[0] = name[3];
> +}
> +
> +static int sdsi_state_cert_show(struct sdsi_dev *s)
>  {
> -	uint64_t state_certificate[512] = {0};
> -	bool first_instance;
> -	uint64_t previous;
> +	char buf[STATE_CERT_MAX_SIZE] = {0};
> +	struct state_certificate *sc;
> +	struct license_key_info *lki;
> +	uint32_t offset = 0;
> +	uint32_t count = 0;
>  	FILE *cert_ptr;
> -	int i, ret, size;
> +	int ret, size;
>  
>  	ret = sdsi_update_registers(s);
>  	if (ret)
>  		return ret;
>  
>  	if (!s->regs.en_features.sdsi) {
> -		fprintf(stderr, "SDSi feature is present but not enabled.");
> +		fprintf(stderr, "On Demand feature is present but not enabled.");
>  		fprintf(stderr, " Unable to read state certificate");
>  		return -1;
>  	}
> @@ -198,32 +286,74 @@ static int sdsi_certificate_dump(struct sdsi_dev *s)
>  		return -1;
>  	}
>  
> -	size = fread(state_certificate, 1, sizeof(state_certificate), cert_ptr);
> +	size = fread(buf, 1, sizeof(buf), cert_ptr);
>  	if (!size) {
>  		fprintf(stderr, "Could not read 'state_certificate' file\n");
>  		fclose(cert_ptr);
>  		return -1;
>  	}
> +	fclose(cert_ptr);
>  
> -	printf("%3d: 0x%lx\n", 0, state_certificate[0]);
> -	previous = state_certificate[0];
> -	first_instance = true;
> +	sc = (struct state_certificate *)buf;
>  
> -	for (i = 1; i < (int)(round_up(size, sizeof(uint64_t))/sizeof(uint64_t)); i++) {
> -		if (state_certificate[i] == previous) {
> -			if (first_instance) {
> -				puts("*");
> -				first_instance = false;
> -			}
> -			continue;
> +	/* Print register info for this guid */
> +	printf("\n");
> +	printf("State certificate for device %s\n", s->dev_name);
> +	printf("\n");
> +	printf("Content Type:          %s\n", content_type(sc->content_type));
> +	printf("Region Revision ID:    %d\n", sc->region_rev_id);
> +	printf("Header Size:           %d\n", sc->header_size * 4);
> +	printf("Total Size:            %d\n", sc->total_size);
> +	printf("OEM Key Size:          %d\n", sc->key_size * 4);
> +	printf("Number of Licenses:    %d\n", sc->num_licenses);
> +
> +	/* Skip over the license sizes 4 bytes per license) to get the license key info */
> +	lki = (void *)sc + sizeof(*sc) + (4 * sc->num_licenses);
> +
> +	printf("License blob Info:\n");
> +	printf("    License Key Revision ID:    0x%x\n", lki->key_rev_id);
> +	printf("    License Key Image Content:  0x%lx%lx%lx%lx%lx%lx\n",
> +	       lki->key_image_content[5], lki->key_image_content[4],
> +	       lki->key_image_content[3], lki->key_image_content[2],
> +	       lki->key_image_content[1], lki->key_image_content[0]);
> +
> +	while (count++ < sc->num_licenses) {
> +		uint32_t blob_size_field = *(uint32_t *)(buf + 0x14 + count * 4);
> +		uint32_t blob_size = LICENSE_BLOB_SIZE(blob_size_field);
> +		bool license_valid = LICENSE_VALID(blob_size_field);
> +		struct license_blob_content *lbc =
> +			(void *)(sc) +			// start of the state certificate
> +			sizeof(*sc) +			// size of the state certificate
> +			(4 * sc->num_licenses) +	// total size of the blob size blocks
> +			sizeof(*lki) +			// size of the license key info
> +			offset;				// offset to this blob content
> +		struct bundle_encoding *bundle = (void *)(lbc) + sizeof(*lbc);
> +		char feature[5];
> +		uint32_t i;
> +
> +		printf("     Blob %d:\n", count - 1);
> +		printf("        License blob size:          %u\n", blob_size);
> +		printf("        License is valid:           %s\n", license_valid ? "Yes" : "No");
> +		printf("        License blob type:          %s\n", license_blob_type(lbc->type));
> +		printf("        License blob ID:            0x%lx\n", lbc->id);
> +		printf("        PPIN:                       0x%lx\n", lbc->ppin);
> +		printf("        Previous PPIN:              0x%lx\n", lbc->previous_ppin);
> +		printf("        Blob revision ID:           %u\n", lbc->rev_id);
> +		printf("        Number of Features:         %u\n", lbc->num_bundles);
> +
> +		feature[4] = '\0';
> +
> +		for (i = 0; i < min(lbc->num_bundles, STATE_MAX_NUM_IN_BUNDLE); i++) {
> +			get_feature(bundle[i].encoding, feature);
> +			printf("                 Feature %d:         %s\n", i, feature);
>  		}
> -		printf("%3d: 0x%lx\n", i, state_certificate[i]);
> -		previous = state_certificate[i];
> -		first_instance = true;
> -	}
> -	printf("%3d\n", i);
>  
> -	fclose(cert_ptr);
> +		if (lbc->num_bundles > STATE_MAX_NUM_IN_BUNDLE)
> +			fprintf(stderr, "        Warning: %d > %d licenses in bundle reported.\n",
> +				lbc->num_bundles, STATE_MAX_NUM_IN_BUNDLE);
> +
> +		offset += blob_size;
> +	};
>  
>  	return 0;
>  }
> @@ -231,7 +361,7 @@ static int sdsi_certificate_dump(struct sdsi_dev *s)
>  static int sdsi_provision(struct sdsi_dev *s, char *bin_file, enum command command)
>  {
>  	int bin_fd, prov_fd, size, ret;
> -	char buf[4096] = { 0 };
> +	char buf[STATE_CERT_MAX_SIZE] = { 0 };
>  	char cap[] = "provision_cap";
>  	char akc[] = "provision_akc";
>  	char *prov_file;
> @@ -266,7 +396,7 @@ static int sdsi_provision(struct sdsi_dev *s, char *bin_file, enum command comma
>  	}
>  
>  	/* Read the binary file into the buffer */
> -	size = read(bin_fd, buf, 4096);
> +	size = read(bin_fd, buf, STATE_CERT_MAX_SIZE);
>  	if (size == -1) {
>  		close(bin_fd);
>  		close(prov_fd);
> @@ -443,25 +573,26 @@ static void sdsi_free_dev(struct sdsi_dev *s)
>  
>  static void usage(char *prog)
>  {
> -	printf("Usage: %s [-l] [-d DEVNO [-iD] [-a FILE] [-c FILE]]\n", prog);
> +	printf("Usage: %s [-l] [-d DEVNO [-i] [-s] [-a FILE] [-c FILE]]\n", prog);
>  }
>  
>  static void show_help(void)
>  {
>  	printf("Commands:\n");
> -	printf("  %-18s\t%s\n", "-l, --list",		"list available sdsi devices");
> -	printf("  %-18s\t%s\n", "-d, --devno DEVNO",	"sdsi device number");
> -	printf("  %-18s\t%s\n", "-i --info",		"show socket information");
> -	printf("  %-18s\t%s\n", "-D --dump",		"dump state certificate data");
> -	printf("  %-18s\t%s\n", "-a --akc FILE",	"provision socket with AKC FILE");
> -	printf("  %-18s\t%s\n", "-c --cap FILE>",	"provision socket with CAP FILE");
> +	printf("  %-18s\t%s\n", "-l, --list",           "list available On Demand devices");
> +	printf("  %-18s\t%s\n", "-d, --devno DEVNO",    "On Demand device number");
> +	printf("  %-18s\t%s\n", "-i, --info",           "show socket information");
> +	printf("  %-18s\t%s\n", "-s, --state",          "show state certificate");
> +	printf("  %-18s\t%s\n", "-a, --akc FILE",       "provision socket with AKC FILE");
> +	printf("  %-18s\t%s\n", "-c, --cap FILE>",      "provision socket with CAP FILE");
>  }
>  
>  int main(int argc, char *argv[])
>  {
>  	char bin_file[PATH_MAX], *dev_no = NULL;
> +	bool device_selected = false;
>  	char *progname;
> -	enum command command = CMD_NONE;
> +	enum command command = -1;
>  	struct sdsi_dev *s;
>  	int ret = 0, opt;
>  	int option_index = 0;
> @@ -470,21 +601,22 @@ int main(int argc, char *argv[])
>  		{"akc",		required_argument,	0, 'a'},
>  		{"cap",		required_argument,	0, 'c'},
>  		{"devno",	required_argument,	0, 'd'},
> -		{"dump",	no_argument,		0, 'D'},
>  		{"help",	no_argument,		0, 'h'},
>  		{"info",	no_argument,		0, 'i'},
>  		{"list",	no_argument,		0, 'l'},
> +		{"state",	no_argument,		0, 's'},
>  		{0,		0,			0, 0 }
>  	};
>  
>  
>  	progname = argv[0];
>  
> -	while ((opt = getopt_long_only(argc, argv, "+a:c:d:Da:c:h", long_options,
> +	while ((opt = getopt_long_only(argc, argv, "+a:c:d:hils", long_options,
>  			&option_index)) != -1) {
>  		switch (opt) {
>  		case 'd':
>  			dev_no = optarg;
> +			device_selected = true;
>  			break;
>  		case 'l':
>  			sdsi_list_devices();
> @@ -492,8 +624,8 @@ int main(int argc, char *argv[])
>  		case 'i':
>  			command = CMD_SOCKET_INFO;
>  			break;
> -		case 'D':
> -			command = CMD_DUMP_CERT;
> +		case 's':
> +			command = CMD_STATE_CERT;
>  			break;
>  		case 'a':
>  		case 'c':
> @@ -520,39 +652,35 @@ int main(int argc, char *argv[])
>  		}
>  	}
>  
> -	if (!dev_no) {
> -		if (command != CMD_NONE)
> -			fprintf(stderr, "Missing device number, DEVNO, for this command\n");
> -		usage(progname);
> -		return -1;
> -	}
> +	if (device_selected) {
> +		s = sdsi_create_dev(dev_no);
> +		if (!s)
> +			return -1;
>  
> -	s = sdsi_create_dev(dev_no);
> -	if (!s)
> -		return -1;
> +		switch (command) {
> +		case CMD_SOCKET_INFO:
> +			ret = sdsi_read_reg(s);
> +			break;
> +		case CMD_STATE_CERT:
> +			ret = sdsi_state_cert_show(s);
> +			break;
> +		case CMD_PROV_AKC:
> +			ret = sdsi_provision_akc(s, bin_file);
> +			break;
> +		case CMD_PROV_CAP:
> +			ret = sdsi_provision_cap(s, bin_file);
> +			break;
> +		default:
> +			fprintf(stderr, "No command specified\n");
> +			return -1;
> +		}
> +
> +		sdsi_free_dev(s);
>  
> -	/* Run the command */
> -	switch (command) {
> -	case CMD_NONE:
> -		fprintf(stderr, "Missing command for device %s\n", dev_no);
> -		usage(progname);
> -		break;
> -	case CMD_SOCKET_INFO:
> -		ret = sdsi_read_reg(s);
> -		break;
> -	case CMD_DUMP_CERT:
> -		ret = sdsi_certificate_dump(s);
> -		break;
> -	case CMD_PROV_AKC:
> -		ret = sdsi_provision_akc(s, bin_file);
> -		break;
> -	case CMD_PROV_CAP:
> -		ret = sdsi_provision_cap(s, bin_file);
> -		break;
> -	}
> -
> -
> -	sdsi_free_dev(s);
> +	} else {
> +		fprintf(stderr, "No device specified\n");
> +		return -1;
> +	}
>  
>  	return ret;
>  }

